package com.cugb.javaee.action;

import com.cugb.javaee.bean.*;
import com.cugb.javaee.biz.DishService;
import com.cugb.javaee.biz.OrderService;
import com.cugb.javaee.consumer.UserMessageConsumer;
import com.cugb.javaee.dao.DishDAO;
import com.cugb.javaee.producer.UserMessageProducerImpl;
import com.cugb.javaee.utils.AlipayPaymentUtil;
import com.cugb.javaee.utils.Constants;
import com.cugb.javaee.producer.UserMessageProducer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

/**
 * 订单和支付功能的 Servlet
 */
@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private OrderService orderService = new OrderService();
    private DishService DishService = new DishService();
    private DishDAO dishDAO = new DishDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 获取请求参数
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                // 创建订单
                createOrder(request, response);
                break;
            case "pay":
                // 支付订单
                payOrder(request, response);
                break;
            case "list":
                // 查看订单列表
                listOrders(request, response);
                break;
            case "detail":
                // 查看订单详情
                showOrderDetail(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * 创建订单
     */
    private void createOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查用户是否已登录
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute(Constants.SESSION_USER);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 获取购物车
        Map<Integer, CartItemBean> cart = (Map<Integer, CartItemBean>) session.getAttribute(Constants.SESSION_CART);
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("errorMsg", "购物车为空，无法下单");
            request.getRequestDispatcher("/cart?action=view").forward(request, response);
            return;
        }

        // 计算总金额
        double totalAmount = 0.0;
        List<OrderItemBean> orderItems = new ArrayList<>();
        for (CartItemBean cartItem : cart.values()) {
            OrderItemBean orderItem = new OrderItemBean();
            orderItem.setDishID(cartItem.getDish().getDishID());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setSubtotal(cartItem.getDish().getPrice() * cartItem.getQuantity());
            totalAmount += orderItem.getSubtotal();
            orderItems.add(orderItem);
        }

        // 创建订单对象
        OrderBean order = new OrderBean();
        order.setUserID(user.getUserID());
        order.setTotalAmount(totalAmount);
        order.setOrderStatus(Constants.ORDER_STATUS_PENDING); // 待支付

        // 调用业务逻辑层创建订单
        int orderID = orderService.createOrder(order, orderItems);
        if (orderID > 0) {
            // 清空购物车
            cart.clear();

            // 重定向到支付页面
            response.sendRedirect(request.getContextPath() + "/order?action=pay&orderID=" + orderID);

            // 更新菜品信息
            boolean allStocksChecked = true; // 标记所有库存是否都已检查通过
            for (OrderItemBean orderItem : orderItems) {
                DishBean dish = orderItem.getDish();
                if (dish != null) {
                    int dishID = dish.getDishID();
                    int quantity = orderItem.getQuantity();

                    // 检查库存
                    boolean result = orderService.checkStock(dishID, quantity);
                    if (!result) {
                        // 库存不足，标记为失败
                        allStocksChecked = false;
                        break; // 退出循环
                    }
                } else {
                    // 处理 dish 为 null 的情况
                    System.out.println("Dish is null");
                }
            }

            if (!allStocksChecked) {
                // 库存不足，回滚订单
                orderService.deleteOrder(orderID);
                request.setAttribute("errorMsg", "下单失败，库存不足");
                request.getRequestDispatcher("/cart?action=view").forward(request, response);
                return; // 退出方法
            }

            // 所有库存检查通过，更新库存
            for (OrderItemBean orderItem : orderItems) {
                int dishID = orderItem.getDishID();
                int quantity = orderItem.getQuantity();
                DishBean dishBean = DishService.getDishByID(dishID);
                dishBean.setStock(dishBean.getStock() - quantity);

                // 检查库存是否为零
                if (dishBean.getStock() == 0) {
                    // 发送菜品售罄的消息
                    sendSoldOutMessage(dishBean);
                }

                DishService.updateDish(dishBean);
            }
        } else {
            request.setAttribute("errorMsg", "下单失败");
            request.getRequestDispatcher("/cart?action=view").forward(request, response);
        }
    }

    // 发送菜品售罄的消息
    private void sendSoldOutMessage(DishBean dishBean) {
        UserMessageProducer userMessageProducer = new UserMessageProducerImpl("localhost", "sold_out_queue");
        try {
            userMessageProducer.sendMessage(dishBean, "菜品 " + dishBean.getName() + " 已售罄");
            System.out.println("Sent sold out message for dish: " + dishBean.getName());
        } finally {
            userMessageProducer.close();
        }
    }


    /**
     * 支付订单
     */
    private void payOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查用户是否已登录
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute(Constants.SESSION_USER);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 获取订单ID
        String orderIDStr = request.getParameter("orderID");
        if (orderIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int orderID = Integer.parseInt(orderIDStr);

        // 获取订单详情
        OrderBean order = orderService.getOrderById(orderID);
        if (order == null || order.getUserID() != user.getUserID()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 使用支付宝工具类进行支付
        AlipayPaymentUtil.processPayment("ORDER" + orderID, String.valueOf(order.getTotalAmount()), "购物车订单", response);
        // 不会真付，模拟付款成功
        boolean result = orderService.updateOrderStatus(orderID, Constants.ORDER_STATUS_PAID); // 已支付
        if (result) {
            // 支付成功，重定向到订单列表
            // response.sendRedirect(request.getContextPath() + "/order?action=list");
        } else {
            request.setAttribute("errorMsg", "支付失败");
            request.getRequestDispatcher("/order?action=detail&orderID=" + orderID).forward(request, response);
        }
    }


    //确认是否支付成功，使用支付宝异步通知，使用前去支付宝设置一下notify_url
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 支付宝异步通知处理
        String tradeStatus = request.getParameter("trade_status");
        String outTradeNo = request.getParameter("out_trade_no");

        if ("TRADE_SUCCESS".equals(tradeStatus) || "TRADE_FINISHED".equals(tradeStatus)) {
            // 提取订单ID
            int orderID = Integer.parseInt(outTradeNo.replace("ORDER", ""));
            // 更新订单状态为已支付
            orderService.updateOrderStatus(orderID, Constants.ORDER_STATUS_PAID);
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }
    }


    /**
     * 查看订单列表
     */
    private void listOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查用户是否已登录
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute(Constants.SESSION_USER);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 获取订单列表
        List<OrderBean> orders = orderService.getOrdersByUserId(user.getUserID());

        // 设置请求属性
        request.setAttribute("orders", orders);

        // 转发到订单列表页面
        request.getRequestDispatcher("/WEB-INF/jsp/orderList.jsp").forward(request, response);
    }

    /**
     * 查看订单详情
     */
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查用户是否已登录
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute(Constants.SESSION_USER);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "index.jsp");
            return;
        }

        // 获取订单ID
        String orderIDStr = request.getParameter("orderID");
        if (orderIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int orderID = Integer.parseInt(orderIDStr);

        // 获取订单详情
        OrderBean order = orderService.getOrderById(orderID);
        if (order == null || order.getUserID() != user.getUserID()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 设置请求属性
        request.setAttribute("order", order);

        // 转发到订单详情页面
        request.getRequestDispatcher("/WEB-INF/jsp/orderDetail.jsp").forward(request, response);
    }
}
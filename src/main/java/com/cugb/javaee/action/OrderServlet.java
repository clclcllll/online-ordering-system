package com.cugb.javaee.action;

import com.cugb.javaee.bean.*;
import com.cugb.javaee.biz.OrderService;
import com.cugb.javaee.utils.Constants;

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
                // 模拟支付
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
        } else {
            request.setAttribute("errorMsg", "下单失败");
            request.getRequestDispatcher("/cart?action=view").forward(request, response);
        }
    }

    /**
     * 模拟支付
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

        // 模拟支付，更新订单状态为已支付
        boolean result = orderService.updateOrderStatus(orderID, Constants.ORDER_STATUS_PAID); // 已支付
        if (result) {
            // 支付成功，重定向到订单列表
            response.sendRedirect(request.getContextPath() + "/order?action=list");
        } else {
            request.setAttribute("errorMsg", "支付失败");
            request.getRequestDispatcher("/order?action=detail&orderID=" + orderID).forward(request, response);
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

        // 设置请求属性
        request.setAttribute("order", order);

        // 转发到订单详情页面
        request.getRequestDispatcher("/WEB-INF/jsp/orderDetail.jsp").forward(request, response);
    }
}

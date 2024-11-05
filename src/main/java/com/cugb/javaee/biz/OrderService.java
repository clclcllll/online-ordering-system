package com.cugb.javaee.biz;

import com.cugb.javaee.bean.OrderBean;
import com.cugb.javaee.bean.OrderItemBean;
import com.cugb.javaee.dao.OrderDAO;
import com.cugb.javaee.dao.OrderItemDAO;
import com.cugb.javaee.dao.DishDAO;
import java.util.Date;
import java.util.List;

/**
 * 订单业务逻辑类，处理订单相关的业务操作
 */
public class OrderService {

    private OrderDAO orderDAO = new OrderDAO();
    private OrderItemDAO orderItemDAO = new OrderItemDAO();
    private DishDAO DishDAO = new DishDAO();
    /**
     * 创建新订单
     * @param order 订单对象（不包含订单ID）
     * @param orderItems 订单明细列表
     * @return 创建结果，成功返回新订单ID，失败返回 0
     */
    public int createOrder(OrderBean order, List<OrderItemBean> orderItems) {
        // 设置订单日期和初始状态
        order.setOrderDate(new Date());
        // 添加订单
        int orderID = orderDAO.addOrder(order);
        if (orderID > 0) {
            // 设置订单明细的订单ID
            for (OrderItemBean item : orderItems) {
                item.setOrderID(orderID);
            }
            // 添加订单明细
            int itemResult = orderItemDAO.addOrderItems(orderItems);
            if (itemResult == orderItems.size()) {
                return orderID;
            } else {
                // 添加订单明细失败，需回滚订单（这里简单删除，实际应用中应使用事务管理）
                orderDAO.deleteOrder(orderID);
                return 0;
            }
        } else {
            return 0;
        }
    }

    /**
     * 根据订单ID获取订单详情，包括订单明细
     * @param orderID 订单ID
     * @return 订单对象，包含订单明细列表，未找到返回 null
     */
    public OrderBean getOrderById(int orderID) {
        OrderBean order = orderDAO.getOrderById(orderID);
        if (order != null) {
            List<OrderItemBean> orderItems = orderItemDAO.getOrderItemsByOrderId(orderID);
            order.setOrderItems(orderItems);
        }
        return order;
    }

    /**
     * 获取指定用户的订单列表
     * @param userID 用户ID
     * @return 订单列表
     */
    public List<OrderBean> getOrdersByUserId(int userID) {
        return orderDAO.getOrdersByUserId(userID);
    }

    /**
     * 更新订单状态
     * @param orderID 订单ID
     * @param orderStatus 新的订单状态
     * @return 更新结果，成功返回 true，失败返回 false
     */
    public boolean updateOrderStatus(int orderID, int orderStatus) {
        int result = orderDAO.updateOrderStatus(orderID, orderStatus);
        return result == 1;
    }

    /**
     * 取消订单
     * @param orderID 订单ID
     * @return 取消结果，成功返回 true，失败返回 false
     */
    public boolean cancelOrder(int orderID) {
        int result = orderDAO.updateOrderStatus(orderID, 3); // 3 表示已取消
        return result == 1;
    }

    /**
     * 获取所有订单（管理员）
     * @return 订单列表
     */
    public List<OrderBean> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    /**
     * 删除订单（管理员）
     * @param orderID 订单ID
     * @return 删除结果，成功返回 true，失败返回 false
     */
    public boolean deleteOrder(int orderID) {
        // 删除订单明细
        orderItemDAO.deleteOrderItemsByOrderId(orderID);
        // 删除订单
        int result = orderDAO.deleteOrder(orderID);
        return result == 1;
    }


    public boolean checkStock(int dishID, int quantity) {
        int availableStock = DishDAO.getDishCountByID(dishID);

        // 检查库存是否足够
        return availableStock >= quantity;
    }


}

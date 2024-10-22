package com.cugb.javaee.dao;

import com.cugb.javaee.bean.OrderBean;
import com.cugb.javaee.bean.OrderItemBean;
import com.cugb.javaee.utils.DBUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.Date;
import java.util.List;

/**
 * 订单数据访问对象，处理订单相关的数据库操作
 */
public class OrderDAO {

    private JdbcTemplate jdbcTemplate = DBUtil.getJdbcTemplate();

    /**
     * 创建新订单
     * @param order 订单对象
     * @return 新订单的 ID
     */
    public int addOrder(OrderBean order) {
        String sql = "INSERT INTO `Order` (UserID, OrderDate, TotalAmount, OrderStatus) VALUES (?, ?, ?, ?)";
        // 插入订单数据
        jdbcTemplate.update(sql, order.getUserID(), order.getOrderDate(), order.getTotalAmount(), order.getOrderStatus());
        // 获取新插入的订单 ID
        Integer orderID = jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
        return orderID != null ? orderID : 0;
    }

    /**
     * 根据订单 ID 查询订单
     * @param orderID 订单 ID
     * @return 订单对象，如果不存在则返回 null
     */
    public OrderBean getOrderById(int orderID) {
        String sql = "SELECT * FROM `Order` WHERE OrderID = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(OrderBean.class), orderID);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 获取指定用户的所有订单
     * @param userID 用户 ID
     * @return 订单列表
     */
    public List<OrderBean> getOrdersByUserId(int userID) {
        String sql = "SELECT * FROM `Order` WHERE UserID = ? ORDER BY OrderDate DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(OrderBean.class), userID);
    }

    /**
     * 更新订单状态
     * @param orderID 订单 ID
     * @param orderStatus 新的订单状态
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int updateOrderStatus(int orderID, int orderStatus) {
        String sql = "UPDATE `Order` SET OrderStatus = ? WHERE OrderID = ?";
        return jdbcTemplate.update(sql, orderStatus, orderID);
    }

    /**
     * 获取所有订单（管理员）
     * @return 订单列表
     */
    public List<OrderBean> getAllOrders() {
        String sql = "SELECT * FROM `Order` ORDER BY OrderDate DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(OrderBean.class));
    }

    /**
     * 删除订单（管理员）
     * @param orderID 订单 ID
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int deleteOrder(int orderID) {
        String sql = "DELETE FROM `Order` WHERE OrderID = ?";
        return jdbcTemplate.update(sql, orderID);
    }
}

package com.cugb.javaee.dao;

import com.cugb.javaee.bean.OrderItemBean;
import com.cugb.javaee.utils.DBUtil;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 订单明细数据访问对象，处理订单项相关的数据库操作
 */
public class OrderItemDAO {

    private JdbcTemplate jdbcTemplate = DBUtil.getJdbcTemplate();

    /**
     * 添加订单明细列表
     * @param orderItems 订单明细列表
     * @return 操作结果，成功返回插入的记录数，失败返回 0
     */
    public int addOrderItems(List<OrderItemBean> orderItems) {
        String sql = "INSERT INTO OrderItem (OrderID, DishID, Quantity, Subtotal) VALUES (?, ?, ?, ?)";

        // 将 List<OrderItemBean> 转换为 Object[] 数组进行批量处理
        List<Object[]> batchArgs = orderItems.stream()
                .map(orderItem -> new Object[]{
                        orderItem.getOrderID(),
                        orderItem.getDishID(),
                        orderItem.getQuantity(),
                        orderItem.getSubtotal()
                })
                .collect(Collectors.toList());

        // 使用 batchUpdate() 执行批量插入
        int[] results = jdbcTemplate.batchUpdate(sql, batchArgs);

        // 计算成功插入的记录数
        int successCount = 0;
        for (int result : results) {
            successCount += result;
        }
        return successCount;
    }

    /**
     * 根据订单 ID 获取订单明细列表
     * @param orderID 订单 ID
     * @return 订单明细列表
     */
    public List<OrderItemBean> getOrderItemsByOrderId(int orderID) {
        String sql = "SELECT * FROM OrderItem WHERE OrderID = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(OrderItemBean.class), orderID);
    }

    /**
     * 删除订单明细（当订单被删除时）
     * @param orderID 订单 ID
     * @return 操作结果，成功返回删除的记录数，失败返回 0
     */
    public int deleteOrderItemsByOrderId(int orderID) {
        String sql = "DELETE FROM OrderItem WHERE OrderID = ?";
        return jdbcTemplate.update(sql, orderID);
    }
}

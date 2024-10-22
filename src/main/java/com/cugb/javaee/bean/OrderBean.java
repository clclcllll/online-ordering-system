package com.cugb.javaee.bean;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 订单实体类
 */
public class OrderBean implements Serializable {
    private int orderID;             // 订单ID
    private int userID;              // 用户ID
    private Date orderDate;          // 下单日期
    private double totalAmount;      // 总金额
    private int orderStatus;         // 订单状态（0 - 待支付，1 - 已支付，2 - 已完成等）

    private List<OrderItemBean> orderItems; // 订单明细列表（可选）

    // 无参构造方法
    public OrderBean() {
    }

    // 全参构造方法
    public OrderBean(int orderID, int userID, Date orderDate, double totalAmount, int orderStatus) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.orderStatus = orderStatus;
    }

    // Getter 和 Setter 方法
    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<OrderItemBean> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItemBean> orderItems) {
        this.orderItems = orderItems;
    }
}

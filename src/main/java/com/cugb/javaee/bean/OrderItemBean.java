package com.cugb.javaee.bean;

import java.io.Serializable;

/**
 * 订单明细实体类
 */
public class OrderItemBean implements Serializable {
    private int orderItemID;      // 订单明细ID
    private int orderID;          // 订单ID
    private int dishID;           // 菜品ID
    private int quantity;         // 购买数量
    private double subtotal;      // 小计金额

    private DishBean dish;        // 菜品信息（可选）

    // 无参构造方法
    public OrderItemBean() {
    }

    // 全参构造方法
    public OrderItemBean(int orderItemID, int orderID, int dishID, int quantity, double subtotal) {
        this.orderItemID = orderItemID;
        this.orderID = orderID;
        this.dishID = dishID;
        this.quantity = quantity;
        this.subtotal = subtotal;
    }

    // Getter 和 Setter 方法
    public int getOrderItemID() {
        return orderItemID;
    }

    public void setOrderItemID(int orderItemID) {
        this.orderItemID = orderItemID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getDishID() {
        return dishID;
    }

    public void setDishID(int dishID) {
        this.dishID = dishID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public DishBean getDish() {
        return dish;
    }

    public void setDish(DishBean dish) {
        this.dish = dish;
    }
}

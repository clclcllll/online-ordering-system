package com.cugb.javaee.bean;

import java.io.Serializable;

/**
 * 购物车项实体类
 */
public class CartItemBean implements Serializable {
    private DishBean dish;    // 当前菜品
    private int quantity;     // 购物车中的数量

    // 无参构造方法
    public CartItemBean() {
    }

    // 全参构造方法
    public CartItemBean(DishBean dish, int quantity) {
        this.dish = dish;
        this.quantity = quantity;
    }

    // Getter 和 Setter 方法
    public DishBean getDish() {
        return dish;
    }

    public void setDish(DishBean dish) {
        this.dish = dish;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

package com.cugb.javaee.bean;

import java.io.Serializable;

/**
 * 菜品实体类
 */
public class DishBean implements Serializable {
    private int dishID;           // 菜品ID
    private String name;          // 菜品名称
    private double price;         // 价格
    private String description;   // 描述
    private int stock;            // 库存
    private String image;         // 图片路径

    // 无参构造方法
    public DishBean() {
    }

    // 全参构造方法
    public DishBean(int dishID, String name, double price, String description, int stock, String image) {
        this.dishID = dishID;
        this.name = name;
        this.price = price;
        this.description = description;
        this.stock = stock;
        this.image = image;
    }

    // Getter 和 Setter 方法
    public int getDishID() {
        return dishID;
    }

    public void setDishID(int dishID) {
        this.dishID = dishID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}

package com.cugb.javaee.biz;

import com.cugb.javaee.bean.CartItemBean;
import com.cugb.javaee.bean.DishBean;
import com.cugb.javaee.dao.DishDAO;

import java.util.HashMap;
import java.util.Map;

/**
 * 购物车业务逻辑类，处理购物车相关的业务操作
 */
public class CartService {

    private DishDAO dishDAO = new DishDAO();

    /**
     * 添加商品到购物车
     * @param cart 购物车（使用 Map 存储，键为菜品ID，值为购物车项）
     * @param dishID 菜品ID
     * @param quantity 数量
     * @return 添加结果，成功返回 true，失败返回 false
     */
    public boolean addToCart(Map<Integer, CartItemBean> cart, int dishID, int quantity) {
        // 获取菜品信息
        DishBean dish = dishDAO.getDishByID(dishID);
        if (dish == null || dish.getStock() < quantity) {
            return false;
        }
        // 检查购物车中是否已有该商品
        if (cart.containsKey(dishID)) {
            // 更新数量
            CartItemBean item = cart.get(dishID);
            int newQuantity = item.getQuantity() + quantity;
            if (dish.getStock() < newQuantity) {
                return false;
            }
            item.setQuantity(newQuantity);
        } else {
            // 添加新购物项
            CartItemBean item = new CartItemBean(dish, quantity);
            cart.put(dishID, item);
        }
        return true;
    }

    /**
     * 从购物车中移除商品
     * @param cart 购物车
     * @param dishID 菜品ID
     * @return 移除结果，成功返回 true，失败返回 false
     */
    public boolean removeFromCart(Map<Integer, CartItemBean> cart, int dishID) {
        if (cart.containsKey(dishID)) {
            cart.remove(dishID);
            return true;
        }
        return false;
    }

    /**
     * 更新购物车中商品的数量
     * @param cart 购物车
     * @param dishID 菜品ID
     * @param quantity 新的数量
     * @return 更新结果，成功返回 true，失败返回 false
     */
    public boolean updateCartItem(Map<Integer, CartItemBean> cart, int dishID, int quantity) {
        if (cart.containsKey(dishID)) {
            DishBean dish = dishDAO.getDishByID(dishID);
            if (dish == null || dish.getStock() < quantity) {
                return false;
            }
            CartItemBean item = cart.get(dishID);
            item.setQuantity(quantity);
            return true;
        }
        return false;
    }

    /**
     * 计算购物车总金额
     * @param cart 购物车
     * @return 总金额
     */
    public double calculateTotalAmount(Map<Integer, CartItemBean> cart) {
        double totalAmount = 0.0;
        for (CartItemBean item : cart.values()) {
            totalAmount += item.getDish().getPrice() * item.getQuantity();
        }
        return totalAmount;
    }

    /**
     * 清空购物车
     * @param cart 购物车
     */
    public void clearCart(Map<Integer, CartItemBean> cart) {
        cart.clear();
    }
}

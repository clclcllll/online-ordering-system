package com.cugb.javaee.action;

import com.cugb.javaee.bean.CartItemBean;
import com.cugb.javaee.biz.CartService;
import com.cugb.javaee.utils.Constants;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 购物车功能的 Servlet
 */
@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 获取请求参数
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "add":
                // 添加商品到购物车
                addToCart(request, response);
                break;
            case "remove":
                // 从购物车中移除商品
                removeFromCart(request, response);
                break;
            case "update":
                // 更新购物车中商品的数量
                updateCart(request, response);
                break;
            case "view":
                // 查看购物车
                viewCart(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * 添加商品到购物车
     */
    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取菜品ID和数量
        String dishIDStr = request.getParameter("dishID");
        String quantityStr = request.getParameter("quantity");
        if (dishIDStr == null || quantityStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int dishID = Integer.parseInt(dishIDStr);
        int quantity = Integer.parseInt(quantityStr);

        // 获取购物车
        HttpSession session = request.getSession();
        Map<Integer, CartItemBean> cart = (Map<Integer, CartItemBean>) session.getAttribute(Constants.SESSION_CART);
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute(Constants.SESSION_CART, cart);
        }

        // 添加到购物车
        boolean result = cartService.addToCart(cart, dishID, quantity);
        if (result) {
            // 添加成功，重定向到购物车页面
            response.sendRedirect(request.getContextPath() + "/cart?action=view");
        } else {
            // 添加失败，返回错误信息
            request.setAttribute("errorMsg", "添加到购物车失败，库存不足");
            request.getRequestDispatcher("/dish?action=detail&dishID=" + dishID).forward(request, response);
        }
    }

    /**
     * 从购物车中移除商品
     */
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取菜品ID
        String dishIDStr = request.getParameter("dishID");
        if (dishIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int dishID = Integer.parseInt(dishIDStr);

        // 获取购物车
        HttpSession session = request.getSession();
        Map<Integer, CartItemBean> cart = (Map<Integer, CartItemBean>) session.getAttribute(Constants.SESSION_CART);
        if (cart != null) {
            cartService.removeFromCart(cart, dishID);
        }

        // 重定向到购物车页面
        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }

    /**
     * 更新购物车中商品的数量
     */
    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取菜品ID和新的数量
        String dishIDStr = request.getParameter("dishID");
        String quantityStr = request.getParameter("quantity");
        if (dishIDStr == null || quantityStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int dishID = Integer.parseInt(dishIDStr);
        int quantity = Integer.parseInt(quantityStr);

        // 获取购物车
        HttpSession session = request.getSession();
        Map<Integer, CartItemBean> cart = (Map<Integer, CartItemBean>) session.getAttribute(Constants.SESSION_CART);
        if (cart != null) {
            cartService.updateCartItem(cart, dishID, quantity);
        }

        // 重定向到购物车页面
        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }

    /**
     * 查看购物车
     */
    private void viewCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取购物车
        HttpSession session = request.getSession();
        Map<Integer, CartItemBean> cart = (Map<Integer, CartItemBean>) session.getAttribute(Constants.SESSION_CART);
        if (cart == null) {
            cart = new HashMap<>();
        }

        // 计算总金额
        double totalAmount = cartService.calculateTotalAmount(cart);

        // 设置请求属性
        request.setAttribute("cart", cart);
        request.setAttribute("totalAmount", totalAmount);

        // 转发到购物车页面
        request.getRequestDispatcher("/WEB-INF/jsp/cart.jsp").forward(request, response);
    }
}

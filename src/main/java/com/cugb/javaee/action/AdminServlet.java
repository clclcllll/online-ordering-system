package com.cugb.javaee.action;

import com.cugb.javaee.bean.DishBean;
import com.cugb.javaee.bean.OrderBean;
import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.biz.AdminService;
import com.cugb.javaee.biz.DishService;
import com.cugb.javaee.biz.OrderService;
import com.cugb.javaee.utils.Constants;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * 后台管理的 Servlet
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private AdminService adminService = new AdminService();
    private DishService dishService = new DishService();
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 获取请求参数
        String action = request.getParameter("action");
        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "login":
                // 管理员登录页面
                request.getRequestDispatcher("/WEB-INF/jsp/admin/adminLogin.jsp").forward(request, response);
                break;
            case "logout":
                // 退出登录
                logout(request, response);
                break;
            case "index":
                // 后台首页
                adminIndex(request, response);
                break;
            case "userList":
                // 用户列表
                userList(request, response);
                break;
            case "dishList":
                // 菜品列表
                dishList(request, response);
                break;
            case "orderList":
                // 订单列表
                orderList(request, response);
                break;
            case "addDish":
                // 添加菜品页面
                request.getRequestDispatcher("/WEB-INF/jsp/admin/addDish.jsp").forward(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * 处理管理员登录
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置请求和响应的字符编码
        request.setCharacterEncoding(Constants.CHARSET_UTF8);
        response.setContentType(Constants.CONTENT_TYPE_JSON);

        // 获取请求参数
        String action = request.getParameter("action");
        if (action == null || !action.equals("login")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 获取用户名和密码
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 调用业务逻辑层进行登录验证
        UserBean admin = adminService.login(username, password);

        if (admin != null) {
            // 登录成功，保存管理员信息到 Session
            HttpSession session = request.getSession();
            session.setAttribute(Constants.SESSION_USER, admin);

            // 重定向到后台首页
            response.sendRedirect(request.getContextPath() + "/admin?action=index");
        } else {
            // 登录失败，返回错误信息
            request.setAttribute("errorMsg", "用户名或密码错误");
            request.getRequestDispatcher("/WEB-INF/jsp/admin/adminLogin.jsp").forward(request, response);
        }
    }

    /**
     * 退出登录
     */
    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 清除 Session
        HttpSession session = request.getSession();
        session.invalidate();
        // 重定向到登录页面
        response.sendRedirect(request.getContextPath() + "/admin?action=login");
    }

    /**
     * 后台首页
     */
    private void adminIndex(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 转发到后台首页
        request.getRequestDispatcher("/WEB-INF/jsp/admin/adminIndex.jsp").forward(request, response);
    }

    /**
     * 用户列表
     */
    private void userList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取用户列表
        List<UserBean> users = adminService.getAllUsers();

        // 设置请求属性
        request.setAttribute("users", users);

        // 转发到用户列表页面
        request.getRequestDispatcher("/WEB-INF/jsp/admin/userList.jsp").forward(request, response);
    }

    /**
     * 菜品列表
     */
    private void dishList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取菜品列表
        List<DishBean> dishes = dishService.getAllDishes();

        // 设置请求属性
        request.setAttribute("dishes", dishes);

        // 转发到菜品列表页面
        request.getRequestDispatcher("/WEB-INF/jsp/admin/dishList.jsp").forward(request, response);
    }

    /**
     * 订单列表
     */
    private void orderList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取订单列表
        List<OrderBean> orders = orderService.getAllOrders();

        // 设置请求属性
        request.setAttribute("orders", orders);

        // 转发到订单列表页面
        request.getRequestDispatcher("/WEB-INF/jsp/admin/orderList.jsp").forward(request, response);
    }

    /**
     * 检查用户是否是管理员
     */
    private boolean checkAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute(Constants.SESSION_USER);
        if (user == null || user.getUserType() != Constants.USER_TYPE_ADMIN) {
            response.sendRedirect(request.getContextPath() + "/admin?action=login");
            return false;
        }
        return true;
    }
}

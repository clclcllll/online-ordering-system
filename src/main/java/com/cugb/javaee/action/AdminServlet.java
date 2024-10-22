package com.cugb.javaee.action;

import com.cugb.javaee.bean.DishBean;
import com.cugb.javaee.bean.OrderBean;
import com.cugb.javaee.bean.OrderItemBean;
import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.biz.AdminService;
import com.cugb.javaee.biz.DishService;
import com.cugb.javaee.biz.OrderService;
import com.cugb.javaee.utils.Constants;
import com.cugb.javaee.utils.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
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
            case "deleteUser":
                // 删除用户
                deleteUser(request, response);
                break;
            case "setAdmin":
                // 设置用户为管理员
                setAdmin(request, response);
                break;
            case "removeAdmin":
                // 取消用户的管理员权限
                removeAdmin(request, response);
                break;
            case "dishList":
                // 菜品列表
                dishList(request, response);
                break;
            case "addDish":
                // 添加菜品页面
                request.getRequestDispatcher("/WEB-INF/jsp/admin/addDish.jsp").forward(request, response);
                break;
            case "editDish":
                // 编辑菜品页面
                editDish(request, response);
                break;
            case "deleteDish":
                // 删除菜品
                deleteDish(request, response);
                break;
            case "orderList":
                // 订单列表
                orderList(request, response);
                break;
            case "viewOrder":
                // 查看订单详情
                viewOrder(request, response);
                break;
            case "deleteOrder":
                // 删除订单
                deleteOrder(request, response);
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
        if (action == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        switch (action) {
            case "login":
                // 管理员登录处理
                adminLogin(request, response);
                break;
            case "saveDish":
                // 保存添加或编辑的菜品
                saveDish(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * 管理员登录处理
     */
    private void adminLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
     * 删除用户
     */
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取用户ID
        String userIDStr = request.getParameter("userID");
        if (userIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int userID = Integer.parseInt(userIDStr);

        // 调用业务逻辑层删除用户
        adminService.deleteUser(userID);

        // 重定向到用户列表
        response.sendRedirect(request.getContextPath() + "/admin?action=userList");
    }

    /**
     * 设置用户为管理员
     */
    private void setAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取用户ID
        String userIDStr = request.getParameter("userID");
        if (userIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int userID = Integer.parseInt(userIDStr);

        // 调用业务逻辑层设置用户为管理员
        adminService.setUserAsAdmin(userID);

        // 重定向到用户列表
        response.sendRedirect(request.getContextPath() + "/admin?action=userList");
    }

    /**
     * 取消用户的管理员权限
     */
    private void removeAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取用户ID
        String userIDStr = request.getParameter("userID");
        if (userIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int userID = Integer.parseInt(userIDStr);

        // 调用业务逻辑层取消管理员权限
        adminService.removeAdminPrivileges(userID);

        // 重定向到用户列表
        response.sendRedirect(request.getContextPath() + "/admin?action=userList");
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
     * 编辑菜品页面
     */
    private void editDish(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取菜品ID
        String dishIDStr = request.getParameter("dishID");
        if (dishIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int dishID = Integer.parseInt(dishIDStr);

        // 获取菜品信息
        DishBean dish = dishService.getDishByID(dishID);
        if (dish == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 设置请求属性
        request.setAttribute("dish", dish);

        // 转发到编辑菜品页面（可以复用添加菜品的页面）
        request.getRequestDispatcher("/WEB-INF/jsp/admin/addDish.jsp").forward(request, response);
    }

    /**
     * 保存添加或编辑的菜品
     */
    private void saveDish(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 判断是添加还是编辑（根据是否有 dishID 参数）
        String dishIDStr = request.getParameter("dishID");

        // 获取表单参数
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String stockStr = request.getParameter("stock");
        Part imagePart = request.getPart("image"); // 获取上传的图片文件

        // 参数校验
        if (!ValidationUtil.isValidDishName(name) || !ValidationUtil.isValidPrice(priceStr) || !ValidationUtil.isValidStock(stockStr)) {
            request.setAttribute("errorMsg", "输入的信息格式不正确");
            request.getRequestDispatcher("/WEB-INF/jsp/admin/addDish.jsp").forward(request, response);
            return;
        }

        double price = Double.parseDouble(priceStr);
        int stock = Integer.parseInt(stockStr);

        // 处理图片上传
        String imageFileName = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            // 获取上传的文件名
            String submittedFileName = imagePart.getSubmittedFileName();
            // 生成新的文件名，避免重复
            imageFileName = System.currentTimeMillis() + "_" + submittedFileName;
            // 保存文件到服务器指定目录
            String imagePath = getServletContext().getRealPath("/images/dishes");
            File imageDir = new File(imagePath);
            if (!imageDir.exists()) {
                imageDir.mkdirs();
            }
            imagePart.write(imagePath + File.separator + imageFileName);
        }

        // 创建或更新菜品对象
        DishBean dish = new DishBean();
        dish.setName(name);
        dish.setPrice(price);
        dish.setDescription(description);
        dish.setStock(stock);
        if (imageFileName != null) {
            dish.setImage("dishes/" + imageFileName);
        }

        boolean result;
        if (dishIDStr == null || dishIDStr.isEmpty()) {
            // 添加新菜品
            result = dishService.addDish(dish);
        } else {
            // 更新已有菜品
            int dishID = Integer.parseInt(dishIDStr);
            dish.setDishID(dishID);
            if (imageFileName == null) {
                // 如果没有上传新的图片，保留原来的图片
                DishBean existingDish = dishService.getDishByID(dishID);
                if (existingDish != null) {
                    dish.setImage(existingDish.getImage());
                }
            }
            result = dishService.updateDish(dish);
        }

        if (result) {
            // 操作成功，重定向到菜品列表
            response.sendRedirect(request.getContextPath() + "/admin?action=dishList");
        } else {
            request.setAttribute("errorMsg", "保存菜品失败");
            request.getRequestDispatcher("/WEB-INF/jsp/admin/addDish.jsp").forward(request, response);
        }
    }

    /**
     * 删除菜品
     */
    private void deleteDish(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取菜品ID
        String dishIDStr = request.getParameter("dishID");
        if (dishIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int dishID = Integer.parseInt(dishIDStr);

        // 调用业务逻辑层删除菜品
        dishService.deleteDish(dishID);

        // 重定向到菜品列表
        response.sendRedirect(request.getContextPath() + "/admin?action=dishList");
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
     * 查看订单详情
     */
    private void viewOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取订单ID
        String orderIDStr = request.getParameter("orderID");
        if (orderIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int orderID = Integer.parseInt(orderIDStr);

        // 获取订单详情
        OrderBean order = orderService.getOrderById(orderID);
        if (order == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 设置请求属性
        request.setAttribute("order", order);

        // 转发到订单详情页面
        request.getRequestDispatcher("/WEB-INF/jsp/admin/orderDetail.jsp").forward(request, response);
    }

    /**
     * 删除订单
     */
    private void deleteOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 检查是否是管理员
        if (!checkAdmin(request, response)) {
            return;
        }

        // 获取订单ID
        String orderIDStr = request.getParameter("orderID");
        if (orderIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int orderID = Integer.parseInt(orderIDStr);

        // 调用业务逻辑层删除订单
        orderService.deleteOrder(orderID);

        // 重定向到订单列表
        response.sendRedirect(request.getContextPath() + "/admin?action=orderList");
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

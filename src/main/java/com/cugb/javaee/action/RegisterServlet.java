package com.cugb.javaee.action;

import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.biz.UserService;
import com.cugb.javaee.utils.Constants;
import com.cugb.javaee.utils.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 注册功能的 Servlet
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置请求和响应的字符编码
        request.setCharacterEncoding(Constants.CHARSET_UTF8);
        response.setContentType(Constants.CONTENT_TYPE_JSON);

        // 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");

        // 参数校验
        if (!ValidationUtil.isValidUsername(username) ||
                !ValidationUtil.isValidPassword(password) ||
                !ValidationUtil.isValidEmail(email) ||
                !password.equals(confirmPassword)) {
            request.setAttribute("errorMsg", "输入的信息格式不正确或密码不一致");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        // 创建用户对象
        UserBean user = new UserBean();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);

        // 调用业务逻辑层进行注册
        boolean result = userService.register(user);

        if (result) {
            // 注册成功，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            // 注册失败，返回错误信息
            request.setAttribute("errorMsg", "注册失败，用户名可能已存在");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        }
    }
}

package com.cugb.javaee.action;

import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.biz.UserService;
import com.cugb.javaee.utils.Constants;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 登录功能的 Servlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置请求和响应的字符编码
        request.setCharacterEncoding(Constants.CHARSET_UTF8);
        response.setContentType(Constants.CONTENT_TYPE_JSON);

        // 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 调用业务逻辑层进行登录验证
        UserBean user = userService.login(username, password);

        if (user != null) {
            // 登录成功，保存用户信息到 Session
            HttpSession session = request.getSession();
            session.setAttribute(Constants.SESSION_USER, user);

            // 重定向到首页
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            // 登录失败，返回错误信息
            request.setAttribute("errorMsg", "用户名或密码错误");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        }
    }
}

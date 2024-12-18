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

    //doget
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 转发到登录页面
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置请求和响应的字符编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String captcha = request.getParameter("captcha");

        // 获取存储在 Session 中的验证码
        HttpSession session = request.getSession();
        String sessionCaptcha = (String) session.getAttribute("captcha");

        // 验证验证码
        if (captcha == null || sessionCaptcha == null || !captcha.equalsIgnoreCase(sessionCaptcha)) {
            // 验证码错误
            request.setAttribute("errorMsg", "验证码错误，请重试！");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
            return;
        }

        // 验证码校验通过后，可以移除 Session 中的验证码，防止重复使用
        session.removeAttribute("captcha");

        // 调用业务逻辑层进行登录验证
        UserBean user = userService.login(username, password);

        if (user != null) {
            // 登录成功，保存用户信息到 Session
            session.setAttribute(Constants.SESSION_USER, user);

            // 重定向到首页
            request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
        } else {
            // 登录失败，返回错误信息
            request.setAttribute("errorMsg", "用户名或密码错误");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        }
    }
}

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 转发到注册页面
        request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置请求和响应的字符编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String captchaInput = request.getParameter("captchaInput");

        // 校验验证码
        String captchaSession = (String) request.getSession().getAttribute("captcha");
        if (captchaSession == null || !captchaSession.equalsIgnoreCase(captchaInput)) {
            request.setAttribute("errorMsg", "验证码错误，请重新输入！");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        // 参数校验
        if (!ValidationUtil.isValidUsername(username)) {
            request.setAttribute("errorMsg", "用户名错误，请输入英文或数字");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("errorMsg", "密码格式有误，请确保至少六位数密码");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMsg", "密码不一致，请重新输入");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("errorMsg", "邮箱格式错误");
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
            // 注册成功，设置成功消息并重定向到登录页面
            HttpSession session = request.getSession();
            session.setAttribute("successMsg", "注册成功，请登录。");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // 注册失败，返回错误信息
            request.setAttribute("errorMsg", "注册失败，用户名可能已存在");
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        }
    }
}

package com.cugb.javaee.action;

import com.cugb.javaee.biz.MessageService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/messages")
public class MessageController extends HttpServlet {

    private MessageService messageService = new MessageService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取消息
        List<String> messages = messageService.getAllMessages();

        // 将消息添加到请求中
        request.setAttribute("messages", messages);

        // 转发到JSP页面
        request.getRequestDispatcher("//WEB-INF/jsp/messages.jsp").forward(request, response);

    }
}


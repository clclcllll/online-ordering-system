package com.cugb.javaee.action;

import com.cugb.javaee.consumer.MessageStorage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/fetchMessages")
public class FetchMessagesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 从消息存储获取所有消息
        List<String> messages = MessageStorage.getMessages();

        // 将消息列表传递给 JSP
        request.setAttribute("messages", messages);

        // 转发到 JSP 页面进行展示
        request.getRequestDispatcher("/messages.jsp").forward(request, response);
    }
}

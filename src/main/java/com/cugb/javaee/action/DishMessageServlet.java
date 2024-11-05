package com.cugb.javaee.action;

import com.cugb.javaee.bean.DishBean;
import com.cugb.javaee.producer.UserMessageProducerImpl;
import javax.servlet.ServletException;
import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/sendDishMessage")
public class DishMessageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = getServletContext();
        UserMessageProducerImpl producer = new UserMessageProducerImpl(context, "sold_out_queue");

    }
}


package com.cugb.javaee.listener;

import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class RabbitMQContextListener implements ServletContextListener {

    private Connection connection;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            ConnectionFactory factory = new ConnectionFactory();
            factory.setHost("localhost"); // 设置 RabbitMQ 服务器地址
            connection = factory.newConnection();
            sce.getServletContext().setAttribute("rabbitConnection", connection);
            System.out.println("RabbitMQ connection initialized.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            if (connection != null && connection.isOpen()) {
                connection.close();
                System.out.println("RabbitMQ connection closed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

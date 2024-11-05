package com.cugb.javaee.producer;

import com.google.gson.Gson;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

import javax.servlet.ServletContext;
import java.nio.charset.StandardCharsets;

public class UserMessageProducerImpl extends UserMessageProducer {

    private final Channel channel;
    private final String queueName;
    private Connection connection;

    // 使用 host 和 queueName 的构造函数
    public UserMessageProducerImpl(String host, String queueName) {
        this.queueName = queueName;

        try {
            ConnectionFactory factory = new ConnectionFactory();
            factory.setHost(host);
            this.connection = factory.newConnection();
            this.channel = connection.createChannel();
            this.channel.queueDeclare(queueName, false, false, false, null);
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize producer", e);
        }
    }

    // 使用 ServletContext 和 queueName 的构造函数
    public UserMessageProducerImpl(ServletContext context, String queueName) {
        this.queueName = queueName;
        this.connection = (Connection) context.getAttribute("rabbitConnection");  // 使用共享连接

        try {
            this.channel = connection.createChannel();
            this.channel.queueDeclare(queueName, false, false, false, null);
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize producer channel", e);
        }
    }

    @Override
    public synchronized void sendMessage(Object message, String content) {
        try {
            String json = new Gson().toJson(message);
            String fullMessage = json + "\n" + content;
            channel.basicPublish("", queueName, null, fullMessage.getBytes(StandardCharsets.UTF_8));
            System.out.println(" [x] Sent '" + fullMessage + "'");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void close() {
        try {
            if (channel != null && channel.isOpen()) {
                channel.close();
            }
            // 检查并关闭 connection
            if (connection != null && connection.isOpen()) {
                connection.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

package com.cugb.javaee.producer;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.google.gson.Gson;
import com.cugb.javaee.bean.UserBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class UserMessageProducer {

    private static final Logger logger = LoggerFactory.getLogger(UserMessageProducer.class);
    private final static String QUEUE_NAME = "sold_out_queue";

    public void sendMessage(UserBean user, String message) {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        factory.setPort(5672);
        factory.setUsername("guest");
        factory.setPassword("guest");

        try (Connection connection = factory.newConnection();
             Channel channel = connection.createChannel()) {
            channel.queueDeclare(QUEUE_NAME, true, false, false, null);
            UserMessage userMessage = new UserMessage(user.getUserID(), user.getUsername(), message);
            String jsonMessage = new Gson().toJson(userMessage);
            channel.basicPublish("", QUEUE_NAME, null, jsonMessage.getBytes("UTF-8"));
            logger.info("Sent message to queue: {}", jsonMessage);
        } catch (Exception e) {
            logger.error("Failed to send message to queue", e);
        }
    }

    public abstract void sendMessage(Object message, String content);

    public abstract void close();
}


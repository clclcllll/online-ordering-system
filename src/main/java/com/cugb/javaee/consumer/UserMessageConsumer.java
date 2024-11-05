package com.cugb.javaee.consumer;

import com.cugb.javaee.bean.UserBean;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.DeliverCallback;
import com.google.gson.Gson;
import com.cugb.javaee.producer.UserMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UserMessageConsumer {

    private static final Logger logger = LoggerFactory.getLogger(UserMessageConsumer.class);
    private final static String QUEUE_NAME = "test";

    public void startConsuming() {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        factory.setPort(5672);
        factory.setUsername("guest");
        factory.setPassword("guest");

        try (Connection connection = factory.newConnection();
             Channel channel = connection.createChannel()) {
            DeliverCallback deliverCallback = (consumerTag, delivery) -> {
                String message = new String(delivery.getBody(), "UTF-8");
                UserMessage userMessage = new Gson().fromJson(message, UserMessage.class);
                logger.info("Received message from queue: {}", userMessage);
                processMessage(userMessage);
            };

            channel.basicConsume(QUEUE_NAME, true, deliverCallback, consumerTag -> {});
        } catch (Exception e) {
            logger.error("Failed to consume messages from queue", e);
        }
    }

    private void processMessage(UserMessage userMessage) {
        // 处理接收到的消息
        logger.info("Processing message: {}", userMessage);
        // 可以在这里添加具体的业务逻辑
    }

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
}

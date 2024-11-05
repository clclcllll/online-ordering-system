package com.cugb.javaee.biz;

import com.rabbitmq.client.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeoutException;

public class MessageService {

    private static final String QUEUE_NAME = "sold_out_queue"; // 假设这是你要消费的队列名
    private List<String> messages = new ArrayList<>(); // 存储从队列消费的消息

    public MessageService() {
        // 消费者初始化时自动连接到 RabbitMQ 消费消息
        try {
            // 创建连接工厂
            ConnectionFactory factory = new ConnectionFactory();
            factory.setHost("localhost");  // 连接 RabbitMQ 服务地址
            try (Connection connection = factory.newConnection();
                 Channel channel = connection.createChannel()) {

                // 确保队列存在
                channel.queueDeclare(QUEUE_NAME, false, false, false, null);

                // 设置消费者回调
                DeliverCallback deliverCallback = (consumerTag, delivery) -> {
                    String message = new String(delivery.getBody(), "UTF-8");
                    System.out.println("Received: " + message);
                    // 将消息添加到消息列表
                    messages.add(message);
                };

                // 开始消费消息
                channel.basicConsume(QUEUE_NAME, true, deliverCallback, consumerTag -> {});
            }
        } catch (IOException | TimeoutException e) {
            e.printStackTrace();
        }
    }

    // 获取消息列表
    public List<String> getAllMessages() {
        return messages;
    }
}

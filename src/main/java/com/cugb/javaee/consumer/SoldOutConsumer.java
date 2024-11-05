package com.cugb.javaee.consumer;

import com.rabbitmq.client.*;

import java.io.IOException;

public class SoldOutConsumer {

    private static final String QUEUE_NAME = "sold_out_queue";

    public static void main(String[] args) throws Exception {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        Connection connection = factory.newConnection();
        Channel channel = connection.createChannel();

        // 声明队列
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        System.out.println(" [*] Waiting for messages. To exit press CTRL+C");

        // 创建消息的回调函数
        DeliverCallback deliverCallback = (consumerTag, delivery) -> {
            String message = new String(delivery.getBody(), "UTF-8");
            System.out.println(" [x] Received '" + message + "'");
            // 处理消息并存储到服务器
            MessageStorage.addMessage(message);  // 将接收到的消息存储
        };
        // 开始消费消息
        channel.basicConsume(QUEUE_NAME, true, deliverCallback, consumerTag -> { });
    }
}

package com.cugb.javaee.consumer;

public class ConsumerMain {

    public static void main(String[] args) {
        UserMessageConsumer consumer = new UserMessageConsumer();
        consumer.startConsuming();
    }
}

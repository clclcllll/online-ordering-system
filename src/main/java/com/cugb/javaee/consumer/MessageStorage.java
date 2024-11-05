package com.cugb.javaee.consumer;

import java.util.ArrayList;
import java.util.List;

public class MessageStorage {

    // 存储消息的静态 List
    private static final List<String> messages = new ArrayList<>();

    // 添加消息
    public static void addMessage(String message) {
        synchronized (messages) {
            messages.add(message);
        }
    }

    // 获取所有消息
    public static List<String> getMessages() {
        return new ArrayList<>(messages);
    }
}

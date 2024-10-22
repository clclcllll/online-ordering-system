package com.cugb.javaee.utils;

import com.google.gson.Gson;

/**
 * JSON 工具类，提供对象与 JSON 字符串的转换
 */
public class JSONUtil {

    private static Gson gson = new Gson();

    /**
     * 将对象转换为 JSON 字符串
     * @param obj 要转换的对象
     * @return JSON 字符串
     */
    public static String toJson(Object obj) {
        return gson.toJson(obj);
    }

    /**
     * 将 JSON 字符串转换为指定类型的对象
     * @param json JSON 字符串
     * @param clazz 目标对象的类型
     * @param <T> 泛型类型
     * @return 目标对象
     */
    public static <T> T fromJson(String json, Class<T> clazz) {
        return gson.fromJson(json, clazz);
    }
}

package com.cugb.javaee.utils;

import org.apache.log4j.Logger;

/**
 * 日志工具类，封装日志记录方法
 */
public class LogUtil {

    /**
     * 获取指定类的 Logger 实例
     * @param clazz 类的 Class 对象
     * @return Logger 实例
     */
    public static Logger getLogger(Class<?> clazz) {
        return Logger.getLogger(clazz);
    }

    /**
     * 记录信息级别的日志
     * @param clazz 类的 Class 对象
     * @param message 日志信息
     */
    public static void info(Class<?> clazz, String message) {
        Logger.getLogger(clazz).info(message);
    }

    /**
     * 记录错误级别的日志
     * @param clazz 类的 Class 对象
     * @param message 日志信息
     * @param t 异常对象
     */
    public static void error(Class<?> clazz, String message, Throwable t) {
        Logger.getLogger(clazz).error(message, t);
    }
}

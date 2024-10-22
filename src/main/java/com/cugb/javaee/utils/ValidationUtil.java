package com.cugb.javaee.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 校验工具类，提供常用的数据校验方法
 */
public class ValidationUtil {

    /**
     * 校验邮箱格式
     * @param email 邮箱地址
     * @return 是否符合格式
     */
    public static boolean isValidEmail(String email) {
        String regex = "^[\\w.-]+@[\\w.-]+\\.\\w+$";
        return email != null && email.matches(regex);
    }

    /**
     * 校验手机号码格式
     * @param phone 手机号码
     * @return 是否符合格式
     */
    public static boolean isValidPhone(String phone) {
        String regex = "^1[3-9]\\d{9}$";
        return phone != null && phone.matches(regex);
    }

    /**
     * 校验用户名格式（字母数字下划线，长度为3-16位）
     * @param username 用户名
     * @return 是否符合格式
     */
    public static boolean isValidUsername(String username) {
        String regex = "^[a-zA-Z0-9_]{3,16}$";
        return username != null && username.matches(regex);
    }

    /**
     * 校验密码格式（长度为6-20位）
     * @param password 密码
     * @return 是否符合格式
     */
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >=6 && password.length() <= 20;
    }
}

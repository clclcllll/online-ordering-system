package com.cugb.javaee.utils;

import java.util.Random;

/**
 * 随机码生成工具类，用于生成验证码等
 */
public class RandomCodeUtil {

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    /**
     * 生成指定长度的随机字符串
     * @param length 字符串长度
     * @return 随机字符串
     */
    public static String generateRandomCode(int length) {
        StringBuilder sb = new StringBuilder(length);
        Random random = new Random();

        int charLen = CHARACTERS.length();
        for (int i = 0; i < length; i++) {
            sb.append(CHARACTERS.charAt(random.nextInt(charLen)));
        }
        return sb.toString();
    }
}

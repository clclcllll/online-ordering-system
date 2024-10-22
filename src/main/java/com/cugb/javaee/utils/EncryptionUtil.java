package com.cugb.javaee.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 加密工具类，用于密码加密等功能
 */
public class EncryptionUtil {

    /**
     * 使用 MD5 算法对字符串进行加密
     * @param str 要加密的字符串
     * @return 加密后的字符串
     */
    public static String encryptMD5(String str) {
        return encrypt(str, "MD5");
    }

    /**
     * 使用 SHA-256 算法对字符串进行加密
     * @param str 要加密的字符串
     * @return 加密后的字符串
     */
    public static String encryptSHA256(String str) {
        return encrypt(str, "SHA-256");
    }

    /**
     * 通用加密方法
     * @param str 要加密的字符串
     * @param algorithm 加密算法，如 "MD5"、"SHA-256"
     * @return 加密后的字符串
     */
    private static String encrypt(String str, String algorithm) {
        try {
            // 获取算法实例
            MessageDigest md = MessageDigest.getInstance(algorithm);
            // 更新摘要
            md.update(str.getBytes());
            // 获得密文
            byte[] bytes = md.digest();
            // 把密文转换成十六进制的字符串形式
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                int value = b & 0xff;
                if (value < 16) {
                    sb.append("0");
                }
                sb.append(Integer.toHexString(value));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}

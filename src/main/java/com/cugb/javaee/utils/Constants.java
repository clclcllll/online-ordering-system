package com.cugb.javaee.utils;

/**
 * 常量类，定义项目中使用的常量
 */
public class Constants {

    // 用户类型
    public static final int USER_TYPE_NORMAL = 0;   // 普通用户
    public static final int USER_TYPE_ADMIN = 1;    // 管理员

    // 订单状态
    public static final int ORDER_STATUS_PENDING = 0;     // 待支付
    public static final int ORDER_STATUS_PAID = 1;        // 已支付
    public static final int ORDER_STATUS_COMPLETED = 2;   // 已完成
    public static final int ORDER_STATUS_CANCELLED = 3;   // 已取消

    // Session 中存放的属性名
    public static final String SESSION_USER = "user";
    public static final String SESSION_CART = "cart";

    // 字符编码
    public static final String CHARSET_UTF8 = "UTF-8";

    // 内容类型
    public static final String CONTENT_TYPE_JSON = "application/json;charset=UTF-8";

    // 验证码长度
    public static final int VERIFICATION_CODE_LENGTH = 6;

    // 分页设置
    public static final int PAGE_SIZE = 10; // 每页显示的记录数
}

package com.cugb.javaee.bean;

import java.io.Serializable;

/**
 * 用户实体类
 */
public class UserBean implements Serializable {
    private int userID;         // 用户ID
    private String username;    // 用户名
    private String password;    // 密码
    private String email;       // 邮箱
    private String phone;       // 电话
    private String address;     // 地址
    private int userType;       // 用户类型（0 - 普通用户，1 - 管理员）

    // 无参构造方法
    public UserBean() {
    }

    // 全参构造方法
    public UserBean(int userID, String username, String password, String email, String phone, String address, int userType) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.userType = userType;
    }

    // Getter 和 Setter 方法
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getUserType() {
        return userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }
}

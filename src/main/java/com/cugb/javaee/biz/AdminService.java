package com.cugb.javaee.biz;

import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.dao.AdminDAO;
import com.cugb.javaee.utils.EncryptionUtil;

import java.util.List;

/**
 * 管理员业务逻辑类，处理管理员相关的业务操作
 */
public class AdminService {

    private AdminDAO adminDAO = new AdminDAO();

    /**
     * 管理员登录
     * @param username 用户名
     * @param password 密码（未加密）
     * @return 管理员用户对象，登录失败返回 null
     */
    public UserBean login(String username, String password) {
        // 密码加密
        String encryptedPassword = EncryptionUtil.encryptMD5(password);
        // 验证登录
        return adminDAO.adminLogin(username, encryptedPassword);
    }

    /**
     * 获取所有用户列表
     * @return 用户列表
     */
    public List<UserBean> getAllUsers() {
        return adminDAO.getAllUsers();
    }

    /**
     * 删除用户
     * @param userID 用户ID
     * @return 删除结果，成功返回 true，失败返回 false
     */
    public boolean deleteUser(int userID) {
        int result = adminDAO.deleteUser(userID);
        return result == 1;
    }

    /**
     * 设置用户为管理员
     * @param userID 用户ID
     * @return 操作结果，成功返回 true，失败返回 false
     */
    public boolean setUserAsAdmin(int userID) {
        int result = adminDAO.updateUserType(userID, 1); // 1 表示管理员
        return result == 1;
    }

    /**
     * 取消用户的管理员权限
     * @param userID 用户ID
     * @return 操作结果，成功返回 true，失败返回 false
     */
    public boolean removeAdminPrivileges(int userID) {
        int result = adminDAO.updateUserType(userID, 0); // 0 表示普通用户
        return result == 1;
    }
}

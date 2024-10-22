package com.cugb.javaee.biz;

import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.dao.UserDAO;
import com.cugb.javaee.utils.EncryptionUtil;
import com.cugb.javaee.utils.ValidationUtil;

/**
 * 用户业务逻辑类，处理用户相关的业务操作
 */
public class UserService {

    private UserDAO userDAO = new UserDAO();

    /**
     * 用户注册
     * @param user 用户对象
     * @return 注册结果，成功返回 true，失败返回 false
     */
    public boolean register(UserBean user) {
        // 参数校验
        if (!ValidationUtil.isValidUsername(user.getUsername()) ||
                !ValidationUtil.isValidPassword(user.getPassword()) ||
                !ValidationUtil.isValidEmail(user.getEmail())) {
            return false;
        }
        // 检查用户名是否已存在
        if (userDAO.getUserByUsername(user.getUsername()) != null) {
            return false;
        }
        // 密码加密
        String encryptedPassword = EncryptionUtil.encryptMD5(user.getPassword());
        user.setPassword(encryptedPassword);
        // 设置用户类型为普通用户
        user.setUserType(0);
        // 添加用户
        int result = userDAO.addUser(user);
        return result == 1;
    }

    /**
     * 用户登录
     * @param username 用户名
     * @param password 密码（未加密）
     * @return 用户对象，登录失败返回 null
     */
    public UserBean login(String username, String password) {
        // 密码加密
        String encryptedPassword = EncryptionUtil.encryptMD5(password);
        // 验证登录
        return userDAO.login(username, encryptedPassword);
    }

    /**
     * 更新用户信息
     * @param user 用户对象
     * @return 更新结果，成功返回 true，失败返回 false
     */
    public boolean updateUser(UserBean user) {
        // 参数校验（可根据需要添加更多校验）
        if (!ValidationUtil.isValidEmail(user.getEmail()) ||
                !ValidationUtil.isValidPhone(user.getPhone())) {
            return false;
        }
        // 更新用户信息
        int result = userDAO.updateUser(user);
        return result == 1;
    }

    /**
     * 删除用户
     * @param userID 用户ID
     * @return 删除结果，成功返回 true，失败返回 false
     */
    public boolean deleteUser(int userID) {
        int result = userDAO.deleteUser(userID);
        return result == 1;
    }
}

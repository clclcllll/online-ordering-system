package com.cugb.javaee.dao;

import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.utils.DBUtil;
import com.cugb.javaee.utils.Constants;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * 管理员数据访问对象，处理管理员相关的数据库操作
 */
public class AdminDAO {

    private JdbcTemplate jdbcTemplate = DBUtil.getJdbcTemplate();

    /**
     * 管理员登录验证
     * @param username 用户名
     * @param password 密码（已加密）
     * @return 管理员用户对象，如果验证失败则返回 null
     */
    public UserBean adminLogin(String username, String password) {
        String sql = "SELECT * FROM User WHERE Username = ? AND Password = ? AND UserType = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(UserBean.class),
                    username, password, Constants.USER_TYPE_ADMIN);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    /**
     * 获取所有用户列表
     * @return 用户列表
     */
    public List<UserBean> getAllUsers() {
        String sql = "SELECT * FROM User";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(UserBean.class));
    }

    /**
     * 根据用户 ID 删除用户
     * @param userID 用户 ID
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int deleteUser(int userID) {
        String sql = "DELETE FROM User WHERE UserID = ?";
        return jdbcTemplate.update(sql, userID);
    }

    /**
     * 更新用户类型（设置为管理员或普通用户）
     * @param userID 用户 ID
     * @param userType 用户类型
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int updateUserType(int userID, int userType) {
        String sql = "UPDATE User SET UserType = ? WHERE UserID = ?";
        return jdbcTemplate.update(sql, userType, userID);
    }
}

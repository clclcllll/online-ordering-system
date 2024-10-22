package com.cugb.javaee.dao;

import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.utils.DBUtil;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * 用户数据访问对象，处理用户相关的数据库操作
 */
public class UserDAO {

    private JdbcTemplate jdbcTemplate = DBUtil.getJdbcTemplate();

    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户对象，如果不存在则返回 null
     */
    public UserBean getUserByUsername(String username) {
        String sql = "SELECT * FROM User WHERE Username = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(UserBean.class), username);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    /**
     * 添加新用户
     * @param user 用户对象
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int addUser(UserBean user) {
        String sql = "INSERT INTO User (Username, Password, Email, Phone, Address, UserType) VALUES (?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, user.getUsername(), user.getPassword(), user.getEmail(),
                user.getPhone(), user.getAddress(), user.getUserType());
    }

    /**
     * 根据用户名和密码验证用户登录
     * @param username 用户名
     * @param password 密码（已加密）
     * @return 用户对象，如果验证失败则返回 null
     */
    public UserBean login(String username, String password) {
        String sql = "SELECT * FROM User WHERE Username = ? AND Password = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(UserBean.class), username, password);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    /**
     * 更新用户信息
     * @param user 用户对象
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int updateUser(UserBean user) {
        String sql = "UPDATE User SET Password = ?, Email = ?, Phone = ?, Address = ? WHERE UserID = ?";
        return jdbcTemplate.update(sql, user.getPassword(), user.getEmail(),
                user.getPhone(), user.getAddress(), user.getUserID());
    }

    /**
     * 删除用户
     * @param userID 用户ID
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int deleteUser(int userID) {
        String sql = "DELETE FROM User WHERE UserID = ?";
        return jdbcTemplate.update(sql, userID);
    }
}

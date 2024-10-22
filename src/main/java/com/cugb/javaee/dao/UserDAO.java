package com.cugb.javaee.dao;

import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public UserBean findByUsername(String username) {
        // TODO: Implement database query logic
        return null;
    }

    public boolean insert(UserBean user) {
        // TODO: Implement database insert logic
        return false;
    }
}

package com.cugb.javaee.biz;

import com.cugb.javaee.bean.UserBean;
import com.cugb.javaee.dao.UserDAO;

public class UserService {
    private UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO();
    }

    public boolean login(String username, String password) {
        // TODO: Implement login logic
        return false;
    }

    public boolean register(UserBean user) {
        // TODO: Implement registration logic
        return false;
    }
}

package com.example.mcdse105.service;

import com.example.mcdse105.entity.User;

public interface UserService {
    User registerNewUser(User user);

    boolean verifyUser(String username, String password);
}

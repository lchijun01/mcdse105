package com.example.mcdse105.service;

import com.example.mcdse105.entity.User;
import java.util.List;

public interface UserService {
    User registerNewUser(User user);

    User verifyUser(String username, String password);

    List<User> findAllNonAdminUsers();
    
    void updateUserRole(Long userId, boolean makeAdmin);
}

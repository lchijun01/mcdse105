package com.example.mcdse105.service;

import com.example.mcdse105.entity.User;
import com.example.mcdse105.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired  
    private PasswordEncoder passwordEncoder;

    @Override
    public User registerNewUser(User user) {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new RuntimeException("Username already registered");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    @Override
    public User verifyUser(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if(userOpt.isPresent()) {
            User user = userOpt.get();
            if(passwordEncoder.matches(password, user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    @Override
    public List<User> findAllNonAdminUsers() {
        return userRepository.findByIsAdmin("no");
    }
}

package com.example.mcdse105.controller;

import com.example.mcdse105.entity.User;
import com.example.mcdse105.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class CommonController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String getHomepage() {
        return "index";
    }

    @GetMapping("/register")
    public String getRegistrationPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerNewUser(@ModelAttribute("user") User user) {
        userService.registerNewUser(user);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("username") String username,
            @RequestParam("password") String password,
            Model model) {
        if (userService.verifyUser(username, password)) {
            return "redirect:/"; // Redirect to homepage if login is successful
        } else {
            model.addAttribute("errmsg", "Incorrect username or password. Please try again.");
            return "login"; // Show login page with error message
        }
    }
}

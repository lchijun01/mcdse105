package com.example.mcdse105.controller;

import com.example.mcdse105.entity.Product;
import com.example.mcdse105.entity.User;
import com.example.mcdse105.service.ProductService;
import com.example.mcdse105.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class CommonController {

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public String index(HttpServletRequest request) {
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        return "index";
    }

    @GetMapping("/register")
    public String getRegistrationPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerNewUser(@ModelAttribute("user") User user, Model model) {
        try {
            userService.registerNewUser(user);
            return "redirect:/login";
        } catch (RuntimeException e) {
            model.addAttribute("errmsg", "Username already registered");
            return "register";
        }
    }

    @GetMapping("/login")
    public String getLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("username") String username,
            @RequestParam("password") String password,
            Model model, HttpServletRequest request) {
        if (userService.verifyUser(username, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username); // Set username in session
            return "redirect:/"; // Redirect to homepage if login is successful
        } else {
            model.addAttribute("errmsg", "Incorrect username or password. Please try again.");
            return "login"; // Show login page with error message
        }
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }

    @GetMapping("/product")
    public String getAllProducts(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }

        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "product";
    }

    @GetMapping("/product/{id}")
    public String getProductById(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "product";
    }

    @PostMapping("/product")
    public String addProduct(@ModelAttribute("product") Product product) {
        productService.saveProduct(product);
        return "redirect:/product";
    }

    @GetMapping("/product/{id}/edit")
    public String editProduct(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "redirect:/product";
    }

    @PostMapping("/product/{id}/edit")
    public ResponseEntity<String> updateProduct(@PathVariable Long id, @RequestBody Map<String, String> request) {
        try {
            Long productId = Long.parseLong(request.get("productId"));
            int quantity = Integer.parseInt(request.get("quantity"));
            Product product = productService.getProductById(productId);
            product.setQuantity(quantity);
            productService.saveProduct(product);
            return ResponseEntity.ok().body("Product quantity updated successfully");
        } catch (NumberFormatException e) {
            return ResponseEntity.badRequest().body("Invalid quantity format");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update product quantity");
        }
    }

    @GetMapping("/product/{id}/delete")
    public String deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/product";
    }

}

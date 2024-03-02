package com.example.mcdse105.repository;

import com.example.mcdse105.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
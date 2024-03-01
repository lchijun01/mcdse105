package com.example.mcdse105;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class Mcdse105Application extends SpringBootServletInitializer {

	protected SpringApplicationBuilder config(SpringApplicationBuilder application) {
		return application.sources(Mcdse105Application.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(Mcdse105Application.class, args);
	}

}
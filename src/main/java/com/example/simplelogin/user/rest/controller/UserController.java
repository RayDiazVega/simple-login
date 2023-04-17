package com.example.simplelogin.user.rest.controller;

import com.example.simplelogin.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/api/usuarios")
    public ResponseEntity<List<Map<String, Object>>> findUsers() {
        return ResponseEntity.ok(userService.findUsers());
    }
}

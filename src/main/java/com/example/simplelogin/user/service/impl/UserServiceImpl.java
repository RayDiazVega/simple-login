package com.example.simplelogin.user.service.impl;

import com.example.simplelogin.user.repository.UserRepository;
import com.example.simplelogin.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<Map<String, Object>> findUsers() {
        return userRepository.findUsers();
    }
}

package com.example.simplelogin.rest.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;

@RestController
public class HomeController {

    @GetMapping
    public ModelAndView home(Principal principal) {
        ModelAndView modelAndView = new ModelAndView("home.html");
        modelAndView.addObject("username", principal.getName());
        return modelAndView;
    }
}

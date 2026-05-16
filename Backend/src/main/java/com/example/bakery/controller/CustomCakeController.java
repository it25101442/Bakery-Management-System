package com.example.bakery.controller;

import com.example.bakery.model.CustomCake;
import com.example.bakery.service.CustomCakeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/customcakes")

public class CustomCakeController {
    @Autowired
    private CustomCakeService customCakeService;

    @PostMapping
    public CustomCake addCustomCake(@RequestBody CustomCake customCake) {
        return customCakeService.saveCustomCake(customCake);
    }

    @GetMapping
    public List<CustomCake> getAllCustomCakes() {
        return customCakeService.getAllCustomCakes();
    }
}

package com.example.bakery.service;

import com.example.bakery.model.CustomCake;
import com.example.bakery.repository.CustomCakeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomCakeService {

    @Autowired
    private CustomCakeRepository customCakeRepository;

    public CustomCake saveCustomCake(CustomCake customCake) {
        return customCakeRepository.save(customCake);
    }

    public List<CustomCake> getAllCustomCakes() {
        return customCakeRepository.findAll();
    }
}

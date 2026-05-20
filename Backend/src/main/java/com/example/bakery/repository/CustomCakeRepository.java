package com.example.bakery.repository;

import com.example.bakery.model.CustomCake;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomCakeRepository extends JpaRepository<CustomCake, Long> {
}

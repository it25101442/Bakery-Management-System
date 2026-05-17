package com.example.bakery.repository;

import com.example.bakery.model.Order;
import org.springframework.data.jpa.repository.JpaRepository; //Imports JpaRepository.

public interface OrderRepository extends JpaRepository<Order, Long> {
}


//Use for access database

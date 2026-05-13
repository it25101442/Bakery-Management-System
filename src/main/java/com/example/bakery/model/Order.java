package com.example.bakery.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String customerName;
    private String email;
    private String phone;
    private String address;
    private String city;
    private String zip;
    private String state;
    private String delivery;   // standard | express
    private String payment;    // card | paypal | cash
    private String notes;
    private String items;      // JSON string of cart items
    private double total;
}

package com.example.bakery.model;

import jakarta.persistence.*; //Imports JPA annotations used for database mapping.
import lombok.Getter;
import lombok.Setter; //Imports Lombok annotations.

@Entity //Set this a database entity.
@Getter
@Setter
@Table(name = "orders") //Mapping to database table.
public class Order {

    @Id //Primary key.
    @GeneratedValue(strategy = GenerationType.IDENTITY) //Automatically generates IDs.
    private Long id;

    private String customerName;
    private String email;
    private String phone;
    private String address;
    private String city;
    private String zip;
    private String state;
    private String delivery;   // standard, express.
    private String payment;    // card, paypal, cash.
    private String notes;
    private String items;      // JSON string of cart items.
    private double total;
}

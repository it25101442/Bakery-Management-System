package com.example.bakery.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class CustomCake {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String flavor;
    private String size;
    private String frosting;
    private String message;
    private String specialInstructions;
}

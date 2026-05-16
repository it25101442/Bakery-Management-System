package com.example.bakery.controller; 

import com.example.bakery.model.Order;
import com.example.bakery.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired; //Allows Spring Boot to automatically create and inject objects.
import org.springframework.web.bind.annotation.*; //Imports all web annotations.
import java.util.List;

@RestController //Tells Spring Boot this class is a REST API controller.
@RequestMapping("/api/orders") //Sets the base URL.
public class OrderController {

    @Autowired
    private OrderService orderService; //Automatically injects the OrderService object.

    @PostMapping
    public Order addOrder(@RequestBody Order order) { //@RequestBody: Converts incoming JSON data into a Java object.
        return orderService.saveOrder(order);
    } //Used to create new orders.

    @GetMapping //Used to retrieve data.
    public List<Order> getAllOrders() {
        return orderService.getAllOrders();
    }
}

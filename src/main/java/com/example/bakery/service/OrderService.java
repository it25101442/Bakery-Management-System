package com.example.bakery.service;

import com.example.bakery.model.Order;
import com.example.bakery.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    // CREATE
    public Order saveOrder(Order order) {
        return orderRepository.save(order);
    }

    // READ ALL
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    // READ ONE
    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }

    // UPDATE
    public Optional<Order> updateOrder(Long id, Order updated) {
        return orderRepository.findById(id).map(existing -> {
            existing.setCustomerName(updated.getCustomerName());
            existing.setEmail(updated.getEmail());
            existing.setPhone(updated.getPhone());
            existing.setAddress(updated.getAddress());
            existing.setCity(updated.getCity());
            existing.setZip(updated.getZip());
            existing.setState(updated.getState());
            existing.setDelivery(updated.getDelivery());
            existing.setPayment(updated.getPayment());
            existing.setNotes(updated.getNotes());
            existing.setItems(updated.getItems());
            existing.setTotal(updated.getTotal());
            return orderRepository.save(existing);
        });
    }

    // DELETE
    public boolean deleteOrder(Long id) {
        if (orderRepository.existsById(id)) {
            orderRepository.deleteById(id);
            return true;
        }
        return false;
    }
}

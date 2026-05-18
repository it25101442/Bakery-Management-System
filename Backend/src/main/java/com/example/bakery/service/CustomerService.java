package com.example.bakery.service;

import com.example.bakery.model.Customer;
import com.example.bakery.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerService {

    @Autowired
    private CustomerRepository customerRepository;

    public Customer saveCustomer(Customer customer) {
        return customerRepository.save(customer);
    }

    public List<Customer> getAllCustomers() {
        return customerRepository.findAll();
    }

    public Optional<Customer> findByEmail(String email) {
        return customerRepository.findByEmail(email);
    }

    public boolean authenticate(String email, String password) {
        return customerRepository.findByEmail(email)
                .map(c -> c.getPassword().equals(password))
                .orElse(false);
    }
}

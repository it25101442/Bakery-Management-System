package com.example.bakery.service;

import com.example.bakery.model.Product;
import com.example.bakery.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    // READ ALL
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // READ BY CATEGORY
    public List<Product> getByCategory(String category) {
        return productRepository.findByCategory(category);
    }

    // READ ONE
    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }

    // CREATE
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    // UPDATE
    public Optional<Product> updateProduct(Long id, Product updated) {
        return productRepository.findById(id).map(existing -> {
            existing.setName(updated.getName());
            existing.setDescription(updated.getDescription());
            existing.setPrice(updated.getPrice());
            existing.setCategory(updated.getCategory());
            existing.setImageUrl(updated.getImageUrl());
            return productRepository.save(existing);
        });
    }

    // DELETE
    public boolean deleteProduct(Long id) {
        if (productRepository.existsById(id)) {
            productRepository.deleteById(id);
            return true;
        }
        return false;
    }
}

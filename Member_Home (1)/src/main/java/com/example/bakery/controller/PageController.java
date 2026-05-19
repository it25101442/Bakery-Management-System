package com.example.bakery.controller;

import com.example.bakery.model.Customer;
import com.example.bakery.model.Order;
import com.example.bakery.service.CustomerService;
import com.example.bakery.service.OrderService;
import com.example.bakery.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class PageController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private OrderService orderService;

    // ── Home ──────────────────────────────────────────
    @GetMapping({"/", "index"})
    public String home(Model model) {
        model.addAttribute("featuredProducts", productService.getAllProducts());
        return "index";
    }


    // ── Products ──────────────────────────────────────
    @GetMapping("/products")
    public String products(@RequestParam(required = false) String cat, Model model) {
        if (cat != null && !cat.isEmpty()) {
            model.addAttribute("products", productService.getByCategory(cat));
            model.addAttribute("selectedCat", cat);
        } else {
            model.addAttribute("products", productService.getAllProducts());
            model.addAttribute("selectedCat", "all");
        }
        return "products";
    }

    // ── Cart ──────────────────────────────────────────
    @GetMapping("/cart")
    public String cart() {
        return "cart";
    }

    // ── Login (GET) ────────────────────────────────────
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    // ── Login (POST) ───────────────────────────────────
    @PostMapping("/auth/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        if (customerService.authenticate(email, password)) {
            Customer customer = customerService.findByEmail(email).get();
            session.setAttribute("loggedInUser", customer);
            model.addAttribute("loginSuccess", true);
            model.addAttribute("activeTab", "login");
        } else {
            model.addAttribute("errors",
                    java.util.Map.of("login", "Invalid email or password."));
            model.addAttribute("activeTab", "login");
        }
        return "login";
    }

    // ── Register (POST) ────────────────────────────────
    @PostMapping("/auth/register")
    public String register(@RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String confirmPassword,
                           Model model) {
        if (!password.equals(confirmPassword)) {
            model.addAttribute("errors",
                    java.util.Map.of("register", "Passwords do not match."));
            model.addAttribute("activeTab", "register");
            return "login";
        }
        if (customerService.findByEmail(email).isPresent()) {
            model.addAttribute("errors",
                    java.util.Map.of("register", "Email already registered."));
            model.addAttribute("activeTab", "register");
            return "login";
        }
        Customer c = new Customer();
        c.setName(name);
        c.setEmail(email);
        c.setPassword(password);
        customerService.saveCustomer(c);
        model.addAttribute("registerSuccess", true);
        model.addAttribute("activeTab", "register");
        return "login";
    }

    // ── Checkout (GET) ─────────────────────────────────
    @GetMapping("/checkout")
    public String checkoutPage() {
        return "checkout";
    }

    // ── Checkout (POST) ────────────────────────────────
    @PostMapping("/checkout")
    public String placeOrder(@RequestParam String name,
                             @RequestParam String email,
                             @RequestParam String phone,
                             @RequestParam String address,
                             @RequestParam String city,
                             @RequestParam String zip,
                             @RequestParam String state,
                             @RequestParam String delivery,
                             @RequestParam String payment,
                             @RequestParam(required = false) String notes,
                             @RequestParam(required = false) String cartItems,
                             @RequestParam(required = false, defaultValue = "0") double total,
                             Model model) {
        Order order = new Order();
        order.setCustomerName(name);
        order.setEmail(email);
        order.setPhone(phone);
        order.setAddress(address);
        order.setCity(city);
        order.setZip(zip);
        order.setState(state);
        order.setDelivery(delivery);
        order.setPayment(payment);
        order.setNotes(notes);
        order.setItems(cartItems);
        order.setTotal(total);

        Order saved = orderService.saveOrder(order);
        model.addAttribute("orderSuccess", true);
        model.addAttribute("orderId", saved.getId());
        return "checkout";
    }

    // ── Logout ─────────────────────────────────────────
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}

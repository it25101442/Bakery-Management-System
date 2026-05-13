<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activePage" value="cart" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Cart — Crust &amp; Co.</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
</head>
<body>

<!-- ════════════════════════════════════════
     NAVIGATION
════════════════════════════════════════ -->
<nav class="navbar">
  <a href="${pageContext.request.contextPath}/" class="nav-logo">
    <div class="logo-mark">C</div>
    <span class="logo-text">Crust &amp; Co.</span>
  </a>
  <ul class="nav-links">
    <li><a href="${pageContext.request.contextPath}/"
           class="<c:if test='${activePage == \"home\"}'>active</c:if>">Home</a></li>
    <li><a href="${pageContext.request.contextPath}/products"
           class="<c:if test='${activePage == \"menu\"}'>active</c:if>">Menu</a></li>
    <li>
      <a href="${pageContext.request.contextPath}/cart"
         class="nav-cart <c:if test='${activePage == \"cart\"}'>active</c:if>">
        Cart <span class="cart-badge" id="cartBadge" style="display:none">0</span>
      </a>
    </li>
    <c:choose>
      <c:when test="${not empty sessionScope.loggedInUser}">
        <li><span style="color:var(--gold);font-size:0.75rem;font-weight:600;">
          Hi, ${sessionScope.loggedInUser.name}
        </span></li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
      </c:when>
      <c:otherwise>
        <li><a href="${pageContext.request.contextPath}/login"
               class="<c:if test='${activePage == \"account\"}'>active</c:if>">Account</a></li>
      </c:otherwise>
    </c:choose>
    <li>
      <a href="${pageContext.request.contextPath}/checkout"
         class="btn btn-primary" style="padding:9px 22px;font-size:0.65rem">
        Order Now
      </a>
    </li>
  </ul>
  <button class="hamburger" aria-label="Toggle menu">
    <span></span><span></span><span></span>
  </button>
</nav>

<!-- ════════════════════════════════════════
     PAGE HEADER
════════════════════════════════════════ -->
<div class="page-header">
  <div class="container">
    <span class="eyebrow">Your Selection</span>
    <h1>Cart</h1>
    <p>Review your items before proceeding to checkout.</p>
  </div>
</div>

<!-- ════════════════════════════════════════
     CART CONTENT
════════════════════════════════════════ -->
<main class="container cart-wrap">

  <!-- Empty state -->
  <div class="empty-cart" id="emptyCart">
    <div class="empty-cart-icon">&#9723;</div>
    <h3>Your cart is empty</h3>
    <p>Browse our menu and add something wonderful.</p>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
      Explore the Menu
    </a>
  </div>

  <!-- Cart layout -->
  <div class="cart-layout" id="cartLayout" style="display:none;">

    <!-- Items -->
    <div class="cart-panel">
      <div class="cart-panel-head">
        <h2>Items</h2>
        <span class="cart-count-lbl" id="cartCountLbl">0 items</span>
      </div>
      <div id="cartItemsWrap">
        <!-- Rendered by cart.js -->
      </div>
      <div class="cart-panel-foot">
        <a href="${pageContext.request.contextPath}/products"
           style="font-size:0.68rem;letter-spacing:2px;text-transform:uppercase;color:var(--text-secondary);font-weight:600;transition:color .3s;"
           onmouseover="this.style.color='var(--white)'"
           onmouseout="this.style.color='var(--text-secondary)'">
          &larr; Continue Shopping
        </a>
      </div>
    </div>

    <!-- Summary -->
    <div class="cart-summary">
      <div class="cs-title">Order Summary</div>
      <div class="cs-row"><span>Subtotal</span><span id="csSub">Rs.0.00</span></div>
      <div class="cs-row"><span>Delivery</span><span id="csDel">Rs.500.00</span></div>
      <div class="cs-row"><span>Tax (8%)</span><span id="csTax">Rs.0.00</span></div>
      <div class="cs-row total">
        <span>Total</span>
        <span id="csTot">Rs.0.00</span>
      </div>
      <div class="cs-note">
        <span>Free delivery</span> on orders over Rs.5,000.00
      </div>
      <a href="${pageContext.request.contextPath}/checkout"
         class="btn btn-primary"
         style="width:100%;justify-content:center;padding:14px;margin-bottom:14px;">
        Proceed to Checkout
      </a>
      <p style="text-align:center;font-size:0.68rem;color:var(--text-dim);letter-spacing:0.5px;">
        &#128274; &nbsp;Secure encrypted checkout
      </p>
    </div>

  </div>

</main>

<!-- ════════════════════════════════════════
     FOOTER
════════════════════════════════════════ -->
<footer>
  <div class="footer-top container">
    <div class="footer-brand">
      <a href="${pageContext.request.contextPath}/" class="nav-logo">
        <div class="logo-mark">C</div>
        <span class="logo-text">Crust &amp; Co.</span>
      </a>
      <p>Artisan baked goods crafted with devotion and the world's finest ingredients. Baking joy since 1987.</p>
      <div class="footer-socials">
        <div class="soc-btn">&#9678;</div>
        <div class="soc-btn">&#9678;</div>
        <div class="soc-btn">&#9678;</div>
      </div>
    </div>
    <div class="footer-col">
      <h4>Menu</h4>
      <a href="${pageContext.request.contextPath}/products">All Products</a>
      <a href="${pageContext.request.contextPath}/products?cat=cakes">Cakes</a>
      <a href="${pageContext.request.contextPath}/products?cat=bread">Breads</a>
      <a href="${pageContext.request.contextPath}/products?cat=pastries">Pastries</a>
      <a href="${pageContext.request.contextPath}/products?cat=donuts">Donuts</a>
    </div>
    <div class="footer-col">
      <h4>Account</h4>
      <a href="${pageContext.request.contextPath}/login">Sign In</a>
      <a href="${pageContext.request.contextPath}/login">Register</a>
      <a href="${pageContext.request.contextPath}/cart">My Cart</a>
      <a href="${pageContext.request.contextPath}/checkout">Checkout</a>
    </div>
    <div class="footer-col">
      <h4>Info</h4>
      <a href="#">About Us</a>
      <a href="#">Contact</a>
    </div>
  </div>
  <div class="footer-bottom container">
    <span>&copy; 2026 Crust &amp; Co. All rights reserved.</span>
    <span>Privacy &nbsp;&middot;&nbsp; Terms</span>
  </div>
</footer>

<script src="${pageContext.request.contextPath}/js/cart.js"></script>
<script>
  // Navbar scroll effect
  window.addEventListener('scroll', () => {
    document.querySelector('.navbar').classList.toggle('scrolled', window.scrollY > 20);
  });

  // Hamburger menu
  const hamburger = document.querySelector('.hamburger');
  const navLinks  = document.querySelector('.nav-links');
  hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('open');
    navLinks.classList.toggle('open');
  });
  navLinks.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
      hamburger.classList.remove('open');
      navLinks.classList.remove('open');
    });
  });
</script>

</body>
</html>

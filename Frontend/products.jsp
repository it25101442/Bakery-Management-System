<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activePage" value="menu" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Menu — Crust &amp; Co.</title>
  <meta name="description" content="Browse our full menu of artisan cakes, breads, cupcakes, pastries and donuts." />
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
    <span class="eyebrow">Our Offerings</span>
    <h1>The Full Menu</h1>
    <p>Every item is baked fresh each morning — made by hand with premium ingredients and no shortcuts.</p>
  </div>
</div>

<!-- ════════════════════════════════════════
     PRODUCTS
════════════════════════════════════════ -->
<main class="container">

  <!-- Filter bar — links to server-side filtering -->
  <div class="filter-row">
    <span class="filter-lbl">Filter</span>
    <a href="${pageContext.request.contextPath}/products"
       class="filter-btn <c:if test='${empty selectedCat || selectedCat == \"all\"}'>active</c:if>">
      All Items
    </a>
    <a href="${pageContext.request.contextPath}/products?cat=cakes"
       class="filter-btn <c:if test='${selectedCat == \"cakes\"}'>active</c:if>">
      Cakes
    </a>
    <a href="${pageContext.request.contextPath}/products?cat=bread"
       class="filter-btn <c:if test='${selectedCat == \"bread\"}'>active</c:if>">
      Breads
    </a>
    <a href="${pageContext.request.contextPath}/products?cat=cupcakes"
       class="filter-btn <c:if test='${selectedCat == \"cupcakes\"}'>active</c:if>">
      Cupcakes
    </a>
    <a href="${pageContext.request.contextPath}/products?cat=pastries"
       class="filter-btn <c:if test='${selectedCat == \"pastries\"}'>active</c:if>">
      Pastries
    </a>
    <a href="${pageContext.request.contextPath}/products?cat=donuts"
       class="filter-btn <c:if test='${selectedCat == \"donuts\"}'>active</c:if>">
      Donuts
    </a>
  </div>

  <!-- Product grid — server-side rendered from database -->
  <div class="products-grid" id="productsGrid">
    <c:choose>
      <c:when test="${not empty products}">
        <c:forEach var="p" items="${products}">
          <div class="product-card" data-category="${p.category}">
            <div class="prod-img">
              <c:choose>
                <c:when test="${not empty p.imageUrl}">
                  <img src="${p.imageUrl}" alt="${p.name}" loading="lazy" />
                </c:when>
                <c:otherwise>
                  <img src="https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600&q=80"
                       alt="${p.name}" loading="lazy" />
                </c:otherwise>
              </c:choose>
              <c:if test="${not empty p.badge}">
                <span class="prod-badge">${p.badge}</span>
              </c:if>
            </div>
            <div class="prod-body">
              <div class="prod-cat">${p.category}</div>
              <div class="prod-name">${p.name}</div>
              <div class="prod-desc">${p.description}</div>
              <div class="prod-footer">
                <div class="prod-price">
                  <small>from</small>
                  Rs.<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/>
                </div>
                <button class="atc-btn add-to-cart"
                        data-id="${p.id}"
                        data-name="${p.name}"
                        data-price="${p.price}">
                  Add to Cart
                </button>
              </div>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div style="grid-column:1/-1;text-align:center;padding:80px 0;">
          <p style="color:var(--text-secondary);font-size:0.88rem;">
            No items found in this category.
          </p>
          <a href="${pageContext.request.contextPath}/products"
             class="btn btn-outline" style="margin-top:24px;">
            View All Items
          </a>
        </div>
      </c:otherwise>
    </c:choose>
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
        <div class="soc-btn">&#9678;</div>
      </div>
    </div>
    <div class="footer-col">
      <h4>Menu</h4>
      <a href="${pageContext.request.contextPath}/products">All Products</a>
      <a href="${pageContext.request.contextPath}/products?cat=cakes">Cakes</a>
      <a href="${pageContext.request.contextPath}/products?cat=bread">Breads</a>
      <a href="${pageContext.request.contextPath}/products?cat=cupcakes">Cupcakes</a>
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
      <h4>Company</h4>
      <a href="#">About Us</a>
      <a href="#">Careers</a>
      <a href="#">Press</a>
      <a href="#">Contact</a>
    </div>
  </div>
  <div class="footer-bottom container">
    <span>&copy; 2026 Crust &amp; Co. All rights reserved.</span>
    <span>Privacy Policy &nbsp;&middot;&nbsp; Terms &nbsp;&middot;&nbsp; Cookies</span>
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
  if (hamburger) {
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
  }
</script>

</body>
</html>

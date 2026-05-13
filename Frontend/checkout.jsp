<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activePage" value="checkout" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Checkout — Crust &amp; Co.</title>
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
         class="btn btn-primary <c:if test='${activePage == \"checkout\"}'>active</c:if>"
         style="padding:9px 22px;font-size:0.65rem">
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
    <span class="eyebrow">Final Step</span>
    <h1>Checkout</h1>
    <p>Provide your details and we'll take care of everything else.</p>
  </div>
</div>

<!-- ════════════════════════════════════════
     CHECKOUT
════════════════════════════════════════ -->
<main class="container checkout-wrap">

  <!-- Order Success (shown after POST) -->
  <div class="order-success" id="orderSuccess"
       style="<c:if test='${not orderSuccess}'>display:none;</c:if>">
    <div class="os-icon">&#10022;</div>
    <h2>Order Confirmed</h2>
    <p>Thank you. Our bakers are already at work. You'll receive a confirmation email shortly.</p>
    <div class="order-id">CC-${not empty orderId ? orderId : 'XXXXXX'}</div>
    <div class="os-actions">
      <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Continue Shopping</a>
      <a href="${pageContext.request.contextPath}/" class="btn btn-outline">Back to Home</a>
    </div>
  </div>

  <!-- Checkout layout (hidden after success) -->
  <c:if test="${not orderSuccess}">
  <div class="checkout-layout" id="checkoutLayout">

    <!-- Form — POSTs to Spring PageController -->
    <div class="checkout-form-card">
      <div class="cfc-head">
        <h2>Delivery Details</h2>
      </div>
      <div class="cfc-body">
        <form id="checkoutForm" method="post"
              action="${pageContext.request.contextPath}/checkout">

          <!-- Hidden fields populated by cart.js -->
          <input type="hidden" name="cartItems" id="cartItemsInput" value="" />
          <input type="hidden" name="total"     id="totalInput"     value="0" />

          <!-- Personal info -->
          <div class="form-section-lbl">Personal Information</div>
          <div class="fld-row">
            <div class="fld">
              <label for="co-name">Full Name *</label>
              <input type="text" id="co-name" name="name"
                     placeholder="Jane Doe" required />
              <div class="fld-error" id="err-name"></div>
            </div>
            <div class="fld">
              <label for="co-email">Email *</label>
              <input type="email" id="co-email" name="email"
                     placeholder="you@example.com" required />
              <div class="fld-error" id="err-email"></div>
            </div>
          </div>
          <div class="fld">
            <label for="co-phone">Phone Number *</label>
            <input type="tel" id="co-phone" name="phone"
                   placeholder="+94 77 000 0000" required />
            <div class="fld-error" id="err-phone"></div>
          </div>

          <!-- Address -->
          <div class="form-section-lbl">Delivery Address</div>
          <div class="fld">
            <label for="co-address">Street Address *</label>
            <input type="text" id="co-address" name="address"
                   placeholder="123 Baker Street" required />
            <div class="fld-error" id="err-address"></div>
          </div>
          <div class="fld-row">
            <div class="fld">
              <label for="co-city">City *</label>
              <input type="text" id="co-city" name="city"
                     placeholder="Colombo" required />
              <div class="fld-error" id="err-city"></div>
            </div>
            <div class="fld">
              <label for="co-zip">ZIP Code</label>
              <input type="text" id="co-zip" name="zip" placeholder="10000" />
            </div>
          </div>
          <div class="fld">
            <label for="co-state">Province / State</label>
            <select id="co-state" name="state">
              <option value="">Select province</option>
              <option>Western</option>
              <option>Central</option>
              <option>Southern</option>
              <option>Northern</option>
              <option>Eastern</option>
              <option>North Western</option>
              <option>North Central</option>
              <option>Uva</option>
              <option>Sabaragamuwa</option>
            </select>
          </div>

          <!-- Delivery option -->
          <div class="form-section-lbl">Delivery Option</div>
          <div class="opt-grid">
            <label class="opt-tile sel" id="tile-standard">
              <input type="radio" name="delivery" value="standard" checked />
              <div class="opt-icon">&#128230;</div>
              <div>
                <div class="opt-label">Standard</div>
                <div class="opt-sub">2–3 days &middot; Rs.500.00</div>
              </div>
            </label>
            <label class="opt-tile" id="tile-express">
              <input type="radio" name="delivery" value="express" />
              <div class="opt-icon">&#9889;</div>
              <div>
                <div class="opt-label">Express</div>
                <div class="opt-sub">Same day &middot; Rs.2,500.00</div>
              </div>
            </label>
          </div>

          <!-- Payment -->
          <div class="form-section-lbl">Payment Method</div>
          <div class="opt-grid pay-grid">
            <label class="opt-tile pay-tile sel" id="tile-card">
              <input type="radio" name="payment" value="card" checked />
              <div class="opt-icon">&#128179;</div>
              <div class="opt-label">Card</div>
            </label>
            <label class="opt-tile pay-tile" id="tile-paypal">
              <input type="radio" name="payment" value="paypal" />
              <div class="opt-icon">P</div>
              <div class="opt-label">PayPal</div>
            </label>
            <label class="opt-tile pay-tile" id="tile-cash">
              <input type="radio" name="payment" value="cash" />
              <div class="opt-icon">&#128181;</div>
              <div class="opt-label">Cash</div>
            </label>
          </div>

          <!-- Notes -->
          <div class="form-section-lbl">Order Notes</div>
          <div class="fld">
            <label for="co-notes">
              Special Instructions
              <span style="color:var(--text-dim);font-weight:300">(optional)</span>
            </label>
            <textarea id="co-notes" name="notes"
                      placeholder="Allergies, delivery instructions, gift messages…"
                      style="min-height:80px;resize:vertical;width:100%;background:var(--black);border:1px solid var(--border);color:var(--white);border-radius:6px;padding:12px;font-family:inherit;"></textarea>
          </div>

          <button type="submit" class="btn btn-primary"
                  style="width:100%;justify-content:center;padding:16px;margin-top:8px;font-size:0.72rem;">
            Place Order
          </button>

          <p style="text-align:center;font-size:0.68rem;color:var(--text-dim);margin-top:16px;letter-spacing:0.5px;">
            &#128274; &nbsp;Your information is encrypted and never shared
          </p>
        </form>
      </div>
    </div>

    <!-- Order Summary -->
    <div class="co-summary">
      <h3>Your Order</h3>
      <div class="co-items" id="coItemsList">
        <!-- Rendered by cart.js -->
      </div>
      <div class="co-totals">
        <div class="cs-row"><span>Subtotal</span><span id="coSub">Rs.0.00</span></div>
        <div class="cs-row"><span>Delivery</span><span id="coDel">Rs.500.00</span></div>
        <div class="cs-row"><span>Tax (8%)</span><span id="coTax">Rs.0.00</span></div>
        <div class="cs-row total">
          <span>Total</span>
          <span id="coTot">Rs.0.00</span>
        </div>
        <div class="cs-note" style="margin-top:16px;">
          <span>Free delivery</span> on orders over Rs.5,000.00
        </div>
      </div>
    </div>

  </div><%-- /checkout-layout --%>
  </c:if>

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

  // Delivery / payment tile selection highlight
  document.querySelectorAll('.opt-tile input[type=radio]').forEach(radio => {
    radio.addEventListener('change', () => {
      const group = radio.getAttribute('name');
      document.querySelectorAll(`.opt-tile input[name="${group}"]`).forEach(r => {
        r.closest('.opt-tile').classList.remove('sel');
      });
      radio.closest('.opt-tile').classList.add('sel');
    });
  });

  // Populate hidden fields and summary before submit
  const form = document.getElementById('checkoutForm');
  if (form) {
    // Render checkout summary from cart
    renderCheckoutSummary();

    form.addEventListener('submit', () => {
      const cart = JSON.parse(localStorage.getItem('cc_cart') || '[]');
      document.getElementById('cartItemsInput').value = JSON.stringify(cart);
      const sub = cart.reduce((s, i) => s + i.price * i.qty, 0);
      const del = sub >= 3000 ? 0 : 1200.99;
      document.getElementById('totalInput').value = (sub + del + sub * 0.08).toFixed(2);
    });
  }
</script>

</body>
</html>

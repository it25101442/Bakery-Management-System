<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activePage" value="account" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Account — Crust &amp; Co.</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body style="display:flex;flex-direction:column;min-height:100vh;">

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
     AUTH SECTION
════════════════════════════════════════ -->
<section class="auth-page">
  <div class="auth-card">

    <!-- Header -->
    <div class="auth-card-header">
      <div class="auth-brand">
        <div class="auth-brand-ring">C</div>
        Crust &amp; Co.
      </div>
      <div class="auth-tabs">
        <button class="auth-tab <c:if test='${empty activeTab || activeTab == \"login\"}'>active</c:if>"
                data-target="loginPane">Sign In</button>
        <button class="auth-tab <c:if test='${activeTab == \"register\"}'>active</c:if>"
                data-target="registerPane">Register</button>
      </div>
    </div>

    <div class="auth-body">

      <!-- ── LOGIN PANE ── -->
      <div class="auth-form <c:if test='${empty activeTab || activeTab == \"login\"}'>active</c:if>"
           id="loginPane">
        <h2 class="auth-title">Welcome back</h2>
        <p class="auth-sub">Access your orders, saved items and member pricing.</p>

        <%-- Login success message --%>
        <c:if test="${loginSuccess}">
          <div class="auth-success" style="display:block;">
            <div class="check-icon">&#10003;</div>
            <h3>Signed In</h3>
            <p>Welcome back to Crust &amp; Co.</p>
          </div>
        </c:if>

        <%-- Login error message --%>
        <c:if test="${not empty errors.login}">
          <div style="background:rgba(229,53,53,0.1);border:1px solid rgba(229,53,53,0.3);
                      color:#e53535;padding:12px 16px;border-radius:6px;
                      font-size:0.8rem;margin-bottom:18px;">
            ${errors.login}
          </div>
        </c:if>

        <form id="loginForm" method="post"
              action="${pageContext.request.contextPath}/auth/login">
          <div class="fld">
            <label for="li-email">Email Address</label>
            <input type="email" id="li-email" name="email"
                   placeholder="you@example.com" autocomplete="email" />
          </div>
          <div class="fld">
            <label for="li-pass">Password</label>
            <input type="password" id="li-pass" name="password"
                   placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;"
                   autocomplete="current-password" />
          </div>
          <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
            <label style="display:flex;gap:8px;align-items:center;font-size:0.72rem;color:var(--text-secondary);cursor:pointer;">
              <input type="checkbox" name="remember" style="accent-color:var(--gold)" /> Remember me
            </label>
            <a href="#" style="font-size:0.72rem;color:var(--gold);">Forgot password?</a>
          </div>
          <button type="submit" class="btn btn-primary"
                  style="width:100%;justify-content:center;padding:14px;">
            Sign In
          </button>
        </form>

        <div class="auth-divider">or continue with</div>
        <div class="social-row">
          <button class="social-btn">
            <i class="fab fa-google" style="color:#EA4335;font-size:1rem;"></i>
            &nbsp; Google
          </button>
          <button class="social-btn">
            <i class="fab fa-apple" style="color:#ffffff;font-size:1.1rem;"></i>
            &nbsp; Apple
          </button>
        </div>
      </div>

      <!-- ── REGISTER PANE ── -->
      <div class="auth-form <c:if test='${activeTab == \"register\"}'>active</c:if>"
           id="registerPane">
        <h2 class="auth-title">Create account</h2>
        <p class="auth-sub">Join for early access, exclusive offers and faster checkout.</p>

        <%-- Register success message --%>
        <c:if test="${registerSuccess}">
          <div class="auth-success" style="display:block;">
            <div class="check-icon">&#10003;</div>
            <h3>Account Created</h3>
            <p>Welcome to Crust &amp; Co. Start exploring.</p>
          </div>
        </c:if>

        <%-- Register error message --%>
        <c:if test="${not empty errors.register}">
          <div style="background:rgba(229,53,53,0.1);border:1px solid rgba(229,53,53,0.3);
                      color:#e53535;padding:12px 16px;border-radius:6px;
                      font-size:0.8rem;margin-bottom:18px;">
            ${errors.register}
          </div>
        </c:if>

        <form id="registerForm" method="post"
              action="${pageContext.request.contextPath}/auth/register">
          <div class="fld">
            <label for="ri-name">Full Name</label>
            <input type="text" id="ri-name" name="name"
                   placeholder="Jane Doe" autocomplete="name" />
          </div>
          <div class="fld">
            <label for="ri-email">Email Address</label>
            <input type="email" id="ri-email" name="email"
                   placeholder="you@example.com" autocomplete="email" />
          </div>
          <div class="fld-row">
            <div class="fld">
              <label for="ri-pass">Password</label>
              <input type="password" id="ri-pass" name="password"
                     placeholder="Min. 6 characters" />
            </div>
            <div class="fld">
              <label for="ri-pass2">Confirm</label>
              <input type="password" id="ri-pass2" name="confirmPassword"
                     placeholder="Repeat" />
            </div>
          </div>
          <div class="fld-check">
            <input type="checkbox" id="ri-terms" name="terms" />
            <label for="ri-terms">
              I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
            </label>
          </div>
          <button type="submit" class="btn btn-primary"
                  style="width:100%;justify-content:center;padding:14px;">
            Create Account
          </button>
        </form>

        <div class="auth-divider">or continue with</div>
        <div class="social-row">
          <button class="social-btn">G &nbsp; Google</button>
          <button class="social-btn">&#127822; &nbsp; Apple</button>
        </div>
      </div>

    </div><%-- /auth-body --%>
  </div><%-- /auth-card --%>
</section>

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

  // Tab switching
  document.querySelectorAll('.auth-tab').forEach(tab => {
    tab.addEventListener('click', () => {
      document.querySelectorAll('.auth-tab').forEach(t => t.classList.remove('active'));
      document.querySelectorAll('.auth-form').forEach(f => f.classList.remove('active'));
      tab.classList.add('active');
      document.getElementById(tab.dataset.target).classList.add('active');
    });
  });
</script>

</body>
</html>

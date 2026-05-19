<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activePage" value="customcake" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Custom Cake — Crust &amp; Co.</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
  <style>
    .custom-cake-page {
      max-width: 720px;
      margin: 60px auto;
      padding: 0 24px 80px;
    }
    .cake-card {
      background: #1a1a2e;
      border: 1px solid rgba(201,168,76,0.2);
      border-radius: 16px;
      padding: 40px;
    }
    .cake-card h2 {
      color: var(--gold, #c9a84c);
      font-size: 1.4rem;
      margin-bottom: 6px;
      text-transform: uppercase;
      letter-spacing: 0.06em;
    }
    .cake-card p.sub {
      color: #888;
      font-size: 0.82rem;
      margin-bottom: 32px;
    }
    .cake-form { display: flex; flex-direction: column; gap: 20px; }
    .fld label {
      display: block;
      color: #aaa;
      font-size: 0.75rem;
      margin-bottom: 7px;
      text-transform: uppercase;
      letter-spacing: 0.04em;
    }
    .fld input, .fld select, .fld textarea {
      width: 100%;
      padding: 12px 16px;
      background: #0d0d1a;
      border: 1px solid #333;
      border-radius: 10px;
      color: #fff;
      font-size: 0.85rem;
      box-sizing: border-box;
      transition: border-color 0.2s;
    }
    .fld input:focus, .fld select:focus, .fld textarea:focus {
      outline: none;
      border-color: var(--gold, #c9a84c);
    }
    .fld textarea { resize: vertical; min-height: 100px; }
    .fld-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }

    /* Size selector */
    .size-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; }
    .size-tile {
      border: 1px solid #333;
      border-radius: 10px;
      padding: 16px 10px;
      text-align: center;
      cursor: pointer;
      transition: border-color 0.2s, background 0.2s;
    }
    .size-tile input { display: none; }
    .size-tile .size-icon { font-size: 1.8rem; display: block; margin-bottom: 6px; }
    .size-tile .size-label { font-size: 0.75rem; color: #aaa; }
    .size-tile .size-name { font-size: 0.85rem; font-weight: 600; color: #fff; }
    .size-tile.sel {
      border-color: var(--gold, #c9a84c);
      background: rgba(201,168,76,0.07);
    }

    /* Frosting selector */
    .frosting-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; }
    .frost-tile {
      border: 1px solid #333;
      border-radius: 10px;
      padding: 14px 16px;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 12px;
      transition: border-color 0.2s, background 0.2s;
    }
    .frost-tile input { display: none; }
    .frost-tile .frost-dot {
      width: 18px; height: 18px; border-radius: 50%;
      border: 2px solid #555; flex-shrink: 0;
    }
    .frost-tile .frost-name { font-size: 0.82rem; color: #ccc; }
    .frost-tile.sel {
      border-color: var(--gold, #c9a84c);
      background: rgba(201,168,76,0.07);
    }
    .frost-tile.sel .frost-dot { border-color: var(--gold, #c9a84c); background: var(--gold, #c9a84c); }

    .btn-submit {
      background: var(--gold, #c9a84c);
      color: #000;
      border: none;
      padding: 14px 32px;
      border-radius: 10px;
      font-weight: 700;
      font-size: 0.9rem;
      cursor: pointer;
      width: 100%;
      margin-top: 8px;
      transition: opacity 0.2s;
    }
    .btn-submit:hover { opacity: 0.88; }

    /* Success */
    .success-box {
      display: none;
      background: rgba(40,167,69,0.1);
      border: 1px solid rgba(40,167,69,0.3);
      border-radius: 10px;
      padding: 24px;
      text-align: center;
      margin-bottom: 24px;
    }
    .success-box .check { font-size: 2.5rem; }
    .success-box h3 { color: #4caf7d; margin: 10px 0 6px; }
    .success-box p { color: #888; font-size: 0.82rem; }

    .divider { border: none; border-top: 1px solid #222; margin: 4px 0; }
  </style>
</head>
<body>

<!-- NAVIGATION -->
<nav class="navbar">
  <a href="${pageContext.request.contextPath}/" class="nav-logo">
    <div class="logo-mark">C</div>
    <span class="logo-text">Crust &amp; Co.</span>
  </a>
  <ul class="nav-links">
    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
    <li><a href="${pageContext.request.contextPath}/products">Menu</a></li>
    <li><a href="${pageContext.request.contextPath}/customcake" class="active">Custom Cake</a></li>
    <li>
      <a href="${pageContext.request.contextPath}/cart" class="nav-cart">
        Cart <span class="cart-badge" id="cartBadge" style="display:none">0</span>
      </a>
    </li>
    <c:choose>
      <c:when test="${not empty sessionScope.loggedInUser}">
        <li><span style="color:var(--gold);font-size:0.75rem;font-weight:600;">
          Hi, ${sessionScope.loggedInUser.name}
          <c:if test="${sessionScope.isAdmin}">
            <span style="background:var(--gold);color:#000;font-size:0.6rem;font-weight:700;
                         padding:2px 7px;border-radius:4px;margin-left:6px;">ADMIN</span>
          </c:if>
        </span></li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
      </c:when>
      <c:otherwise>
        <li><a href="${pageContext.request.contextPath}/login">Account</a></li>
      </c:otherwise>
    </c:choose>
    <li>
      <a href="${pageContext.request.contextPath}/checkout"
         class="btn btn-primary" style="padding:9px 22px;font-size:0.65rem">Order Now</a>
    </li>
  </ul>
  <button class="hamburger" aria-label="Toggle menu">
    <span></span><span></span><span></span>
  </button>
</nav>

<!-- PAGE HEADER -->
<div class="page-header">
  <div class="container">
    <span class="eyebrow">Made Just For You</span>
    <h1>Design Your Custom Cake</h1>
    <p>Choose your flavour, size, frosting and add a personal message. We'll bake it fresh for you.</p>
  </div>
</div>

<!-- FORM -->
<div class="custom-cake-page">
  <div class="cake-card">
    <h2>&#127874; Cake Builder</h2>
    <p class="sub">Fill in the details below and we'll get started on your dream cake.</p>

    <!-- Success message -->
    <div class="success-box" id="successBox">
      <div class="check">&#10003;</div>
      <h3>Order Received!</h3>
      <p>Your custom cake request has been submitted. We'll contact you to confirm the details.</p>
    </div>

    <form class="cake-form" id="customCakeForm">

      <!-- Flavour -->
      <div class="fld">
        <label>Cake Flavour *</label>
        <select id="ccFlavor" required>
          <option value="">-- Select a flavour --</option>
          <option value="Chocolate Fudge">Chocolate Fudge</option>
          <option value="Vanilla Bean">Vanilla Bean</option>
          <option value="Red Velvet">Red Velvet</option>
          <option value="Lemon Zest">Lemon Zest</option>
          <option value="Strawberry">Strawberry</option>
          <option value="Caramel Crunch">Caramel Crunch</option>
          <option value="Black Forest">Black Forest</option>
          <option value="Butter Scotch">Butter Scotch</option>
        </select>
      </div>

      <hr class="divider" />

      <!-- Size -->
      <div class="fld">
        <label>Cake Size *</label>
        <div class="size-grid">
          <label class="size-tile sel" id="tile-small">
            <input type="radio" name="ccSize" value="Small (500g)" checked />
            <span class="size-icon">&#127859;</span>
            <div class="size-name">Small</div>
            <div class="size-label">500g · 4–6 pax</div>
          </label>
          <label class="size-tile" id="tile-medium">
            <input type="radio" name="ccSize" value="Medium (1kg)" />
            <span class="size-icon">&#127856;</span>
            <div class="size-name">Medium</div>
            <div class="size-label">1kg · 8–12 pax</div>
          </label>
          <label class="size-tile" id="tile-large">
            <input type="radio" name="ccSize" value="Large (2kg)" />
            <span class="size-icon">&#127874;</span>
            <div class="size-name">Large</div>
            <div class="size-label">2kg · 16–20 pax</div>
          </label>
        </div>
      </div>

      <hr class="divider" />

      <!-- Frosting -->
      <div class="fld">
        <label>Frosting Type *</label>
        <div class="frosting-grid">
          <label class="frost-tile sel" id="frost-butter">
            <input type="radio" name="ccFrosting" value="Buttercream" checked />
            <div class="frost-dot"></div>
            <div class="frost-name">Buttercream</div>
          </label>
          <label class="frost-tile" id="frost-fondant">
            <input type="radio" name="ccFrosting" value="Fondant" />
            <div class="frost-dot"></div>
            <div class="frost-name">Fondant</div>
          </label>
          <label class="frost-tile" id="frost-whipped">
            <input type="radio" name="ccFrosting" value="Whipped Cream" />
            <div class="frost-dot"></div>
            <div class="frost-name">Whipped Cream</div>
          </label>
          <label class="frost-tile" id="frost-ganache">
            <input type="radio" name="ccFrosting" value="Chocolate Ganache" />
            <div class="frost-dot"></div>
            <div class="frost-name">Chocolate Ganache</div>
          </label>
        </div>
      </div>

      <hr class="divider" />

      <!-- Message & Instructions -->
      <div class="fld-row">
        <div class="fld">
          <label>Cake Message</label>
          <input type="text" id="ccMessage" placeholder="e.g. Happy Birthday Sarah!" maxlength="60" />
        </div>
        <div class="fld">
          <label>Special Instructions</label>
          <input type="text" id="ccInstructions" placeholder="e.g. Nut-free, extra moist..." />
        </div>
      </div>

      <button type="button" class="btn-submit" onclick="submitCustomCake()">
        &#127874; &nbsp; Submit My Cake Order
      </button>

    </form>
  </div>
</div>

<!-- FOOTER -->
<footer>
  <div class="footer-top container">
    <div class="footer-brand">
      <a href="${pageContext.request.contextPath}/" class="nav-logo">
        <div class="logo-mark">C</div>
        <span class="logo-text">Crust &amp; Co.</span>
      </a>
      <p>Artisan baked goods crafted with devotion and the world's finest ingredients.</p>
    </div>
    <div class="footer-col">
      <h4>Menu</h4>
      <a href="${pageContext.request.contextPath}/products">All Products</a>
      <a href="${pageContext.request.contextPath}/customcake">Custom Cake</a>
    </div>
    <div class="footer-col">
      <h4>Account</h4>
      <a href="${pageContext.request.contextPath}/login">Sign In</a>
      <a href="${pageContext.request.contextPath}/cart">My Cart</a>
      <a href="${pageContext.request.contextPath}/checkout">Checkout</a>
    </div>
  </div>
  <div class="footer-bottom container">
    <span>&copy; 2026 Crust &amp; Co. All rights reserved.</span>
  </div>
</footer>

<script src="${pageContext.request.contextPath}/js/cart.js"></script>
<script>
  const ctx = '${pageContext.request.contextPath}';

  // Size tile selection
  document.querySelectorAll('.size-tile input').forEach(input => {
    input.addEventListener('change', () => {
      document.querySelectorAll('.size-tile').forEach(t => t.classList.remove('sel'));
      input.closest('.size-tile').classList.add('sel');
    });
  });

  // Frosting tile selection
  document.querySelectorAll('.frost-tile input').forEach(input => {
    input.addEventListener('change', () => {
      document.querySelectorAll('.frost-tile').forEach(t => t.classList.remove('sel'));
      input.closest('.frost-tile').classList.add('sel');
    });
  });

  // Submit
  async function submitCustomCake() {
    const flavor  = document.getElementById('ccFlavor').value;
    const size    = document.querySelector('input[name="ccSize"]:checked')?.value;
    const frosting = document.querySelector('input[name="ccFrosting"]:checked')?.value;
    const message = document.getElementById('ccMessage').value;
    const instructions = document.getElementById('ccInstructions').value;

    if (!flavor) { alert('Please select a cake flavour.'); return; }

    const body = { flavor, size, frosting, message, specialInstructions: instructions };

    try {
      const res = await fetch(ctx + '/api/customcakes', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body)
      });
      if (res.ok) {
        document.getElementById('successBox').style.display = 'block';
        document.getElementById('customCakeForm').style.display = 'none';
        window.scrollTo({ top: 0, behavior: 'smooth' });
      } else {
        alert('Something went wrong. Please try again.');
      }
    } catch (err) {
      alert('Could not connect to the server. Please try again.');
    }
  }

  // Navbar scroll
  window.addEventListener('scroll', () => {
    document.querySelector('.navbar').classList.toggle('scrolled', window.scrollY > 20);
  });

  // Hamburger
  const hamburger = document.querySelector('.hamburger');
  const navLinks  = document.querySelector('.nav-links');
  if (hamburger) {
    hamburger.addEventListener('click', () => {
      hamburger.classList.toggle('open');
      navLinks.classList.toggle('open');
    });
  }
</script>
</body>
</html>

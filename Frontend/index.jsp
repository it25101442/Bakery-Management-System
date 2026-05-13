<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activePage" value="home" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Crust &amp; Co. — Artisan Bakery</title>
  <meta name="description" content="Premium artisan bakery — handcrafted cakes, breads, pastries and more." />
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
     HERO
════════════════════════════════════════ -->
<section class="hero">
  <div class="hero-bg" style="background-image:url('https://images.unsplash.com/photo-1509440159596-0249088772ff?w=1800&q=80')"></div>
  <div class="hero-overlay"></div>
  <div class="hero-content">
    <div class="hero-label">
      <div class="hero-label-line"></div>
      <span class="eyebrow" style="margin-bottom:0">Est. 1987 &nbsp;·&nbsp; Artisan Craft</span>
    </div>
    <h1>Where Every<br><em>Crumb</em> Counts</h1>
    <p class="hero-sub">Handcrafted cakes, breads, and pastries made from the world's finest ingredients — baked fresh every morning without compromise.</p>
    <div class="hero-cta">
      <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Explore Our Menu</a>
      <a href="#story" class="btn btn-outline">Our Story</a>
    </div>
  </div>
  <div class="hero-scroll">
    <div class="hero-scroll-bar"></div>
    Scroll
  </div>
</section>

<!-- ════════════════════════════════════════
     MARQUEE
════════════════════════════════════════ -->
<div class="marquee-strip" aria-hidden="true">
  <div class="marquee-inner">
    <span class="marquee-item">Artisan Cakes <span class="marquee-dot"></span></span>
    <span class="marquee-item">Sourdough Breads <span class="marquee-dot"></span></span>
    <span class="marquee-item">Butter Croissants <span class="marquee-dot"></span></span>
    <span class="marquee-item">French Pastries <span class="marquee-dot"></span></span>
    <span class="marquee-item">Hand-crafted Donuts <span class="marquee-dot"></span></span>
    <span class="marquee-item">Premium Cupcakes <span class="marquee-dot"></span></span>
    <span class="marquee-item">Free Delivery Over Rs.3,000.00 <span class="marquee-dot"></span></span>
    <span class="marquee-item">Baked Fresh Daily <span class="marquee-dot"></span></span>
    <span class="marquee-item">Artisan Cakes <span class="marquee-dot"></span></span>
    <span class="marquee-item">Sourdough Breads <span class="marquee-dot"></span></span>
    <span class="marquee-item">Butter Croissants <span class="marquee-dot"></span></span>
    <span class="marquee-item">French Pastries <span class="marquee-dot"></span></span>
    <span class="marquee-item">Hand-crafted Donuts <span class="marquee-dot"></span></span>
    <span class="marquee-item">Premium Cupcakes <span class="marquee-dot"></span></span>
    <span class="marquee-item">Free Delivery Over Rs.3,000.00 <span class="marquee-dot"></span></span>
    <span class="marquee-item">Baked Fresh Daily <span class="marquee-dot"></span></span>
  </div>
</div>

<!-- ════════════════════════════════════════
     STATS
════════════════════════════════════════ -->
<div class="stats-row">
  <div class="stat-cell reveal">
    <div class="stat-num">200<sup>+</sup></div>
    <div class="stat-lbl">Unique Recipes</div>
  </div>
  <div class="stat-cell reveal" style="transition-delay:.08s">
    <div class="stat-num">15<sup>K</sup></div>
    <div class="stat-lbl">Happy Customers</div>
  </div>
  <div class="stat-cell reveal" style="transition-delay:.16s">
    <div class="stat-num">37</div>
    <div class="stat-lbl">Years of Craft</div>
  </div>
  <div class="stat-cell reveal" style="transition-delay:.24s">
    <div class="stat-num">6<sup>AM</sup></div>
    <div class="stat-lbl">Fresh Every Day</div>
  </div>
</div>

<!-- ════════════════════════════════════════
     SPLIT — OUR STORY
════════════════════════════════════════ -->
<div class="split-section" id="story">
  <div class="split-img">
    <img src="https://png.pngtree.com/thumb_back/fw800/background/20230613/pngtree-bakery-with-a-lot-of-bread-and-pastries-image_2927312.jpg"
         alt="Baker shaping artisan bread dough" loading="lazy" />
    <div class="split-img-overlay"></div>
  </div>
  <div class="split-body">
    <span class="eyebrow">Our Philosophy</span>
    <h2 class="sec-title">Craft Before Convenience</h2>
    <p class="sec-sub">We source our flour from single-origin mills, our butter from small Normandy creameries, and our chocolate directly from Valrhona. No shortcuts, no compromises — just exceptional baking, every single day.</p>
    <a href="#" class="btn btn-outline" style="margin-top:36px">About the Bakery</a>
  </div>
</div>

<!-- ════════════════════════════════════════
     FEATURED PRODUCTS — from database
════════════════════════════════════════ -->
<section class="section featured-products">
  <div class="container">
    <div class="text-center reveal">
      <span class="eyebrow">From the Kitchen</span>
      <h2 class="sec-title">Today's Selection</h2>
      <p class="sec-sub">A curated edit of our most-requested bakes — available until sold out.</p>
    </div>

    <div class="fp-grid">
      <c:choose>
        <c:when test="${not empty featuredProducts}">
          <c:forEach var="p" items="${featuredProducts}">
            <div class="fp-card">
              <div class="fp-card-img">
                <c:choose>
                  <c:when test="${not empty p.imageUrl}">
                    <img src="${p.imageUrl}" alt="${p.name}" loading="lazy" />
                  </c:when>
                  <c:otherwise>
                    <img src="https://images.unsplash.com/photo-1509440159596-0249088772ff?w=700&q=80"
                         alt="${p.name}" loading="lazy" />
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="fp-card-body">
                <div class="fp-tag">${p.category}</div>
                <div class="fp-name">${p.name}</div>
                <div class="fp-desc">${p.description}</div>
                <div class="fp-footer">
                  <div class="fp-price">
                    <small>from</small>
                    Rs.<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/>
                  </div>
                  <button class="btn btn-dark add-to-cart"
                          style="padding:8px 16px;font-size:0.6rem"
                          data-id="${p.id}"
                          data-name="${p.name}"
                          data-price="${p.price}">
                    Add
                  </button>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <%-- Fallback static cards if no products in DB yet --%>
          <div class="fp-card">
            <div class="fp-card-img">
              <img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=700&q=80"
                   alt="Dark chocolate layer cake" loading="lazy" />
            </div>
            <div class="fp-card-body">
              <div class="fp-tag">Cakes</div>
              <div class="fp-name">Dark Chocolate Layer Cake</div>
              <div class="fp-desc">Five layers of cocoa sponge with Valrhona ganache and espresso buttercream.</div>
              <div class="fp-footer">
                <div class="fp-price"><small>from</small>Rs.3,500.00</div>
                <button class="btn btn-dark add-to-cart"
                        style="padding:8px 16px;font-size:0.6rem"
                        data-id="1" data-name="Dark Chocolate Layer Cake" data-price="3500">Add</button>
              </div>
            </div>
          </div>
          <div class="fp-card">
            <div class="fp-card-img">
              <img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=700&q=80"
                   alt="All-butter croissant" loading="lazy" />
            </div>
            <div class="fp-card-body">
              <div class="fp-tag">Pastries</div>
              <div class="fp-name">All-Butter Croissant</div>
              <div class="fp-desc">27-layer Charentes butter laminate baked to a shattering golden crisp.</div>
              <div class="fp-footer">
                <div class="fp-price"><small>from</small>Rs.450.00</div>
                <button class="btn btn-dark add-to-cart"
                        style="padding:8px 16px;font-size:0.6rem"
                        data-id="2" data-name="All-Butter Croissant" data-price="450">Add</button>
              </div>
            </div>
          </div>
          <div class="fp-card">
            <div class="fp-card-img">
              <img src="https://images.unsplash.com/photo-1585478259715-876acc5be8eb?w=700&q=80"
                   alt="Country sourdough boule" loading="lazy" />
            </div>
            <div class="fp-card-body">
              <div class="fp-tag">Breads</div>
              <div class="fp-name">Country Sourdough Boule</div>
              <div class="fp-desc">72-hour cold-ferment levain with an open crumb and crackling dark crust.</div>
              <div class="fp-footer">
                <div class="fp-price"><small>from</small>Rs.300.00</div>
                <button class="btn btn-dark add-to-cart"
                        style="padding:8px 16px;font-size:0.6rem"
                        data-id="3" data-name="Country Sourdough Boule" data-price="300">Add</button>
              </div>
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <div style="text-align:center;margin-top:44px">
      <a href="${pageContext.request.contextPath}/products" class="btn btn-outline">View Full Menu</a>
    </div>
  </div>
</section>

<!-- ════════════════════════════════════════
     SPLIT — PROCESS
════════════════════════════════════════ -->
<div class="split-section" style="border-top:1px solid var(--border)">
  <div class="split-body reverse">
    <span class="eyebrow">The Process</span>
    <h2 class="sec-title">Made by Hand,<br>Not by Algorithm</h2>
    <p class="sec-sub">Every loaf is scored, every cake is crumb-coated, and every croissant is laminated by our team of trained pastry chefs — no industrial machinery, no mass production.</p>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-ghost" style="margin-top:36px">Shop Pastries</a>
  </div>
  <div class="split-img">
    <img src="https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=900&q=80"
         alt="Pastry chef decorating a cake" loading="lazy" />
    <div class="split-img-overlay" style="background:linear-gradient(-90deg, transparent 40%, var(--black) 100%)"></div>
  </div>
</div>

<!-- ════════════════════════════════════════
     TESTIMONIALS
════════════════════════════════════════ -->
<section class="section testi-section">
  <div class="container">
    <div class="text-center reveal">
      <span class="eyebrow">Guest Reviews</span>
      <h2 class="sec-title">Voices We Cherish</h2>
    </div>
    <div class="testi-grid">
      <div class="testi-card reveal">
        <div class="testi-stars">★ ★ ★ ★ ★</div>
        <p class="testi-quote">"The chocolate layer cake was the absolute centrepiece of our wedding. Everyone asked where it came from — and now they're all regular customers too."</p>
        <div class="testi-author">
          <div class="testi-avatar">
            <img src="https://images.unsplash.com/photo-1494790108755-2616b612b786?w=80&q=80" alt="Sarah Mitchell" />
          </div>
          <div>
            <div class="testi-name">Sarah Mitchell</div>
            <div class="testi-role">Bride, Loyal Customer</div>
          </div>
        </div>
      </div>
      <div class="testi-card reveal" style="transition-delay:.1s">
        <div class="testi-stars">★ ★ ★ ★ ★</div>
        <p class="testi-quote">"I order a sourdough boule every Saturday morning. It's become sacred. The crust, the crumb — nothing in this city comes close."</p>
        <div class="testi-author">
          <div class="testi-avatar">
            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80&q=80" alt="James Thornton" />
          </div>
          <div>
            <div class="testi-name">James Thornton</div>
            <div class="testi-role">Food Writer</div>
          </div>
        </div>
      </div>
      <div class="testi-card reveal" style="transition-delay:.2s">
        <div class="testi-stars">★ ★ ★ ★ ★</div>
        <p class="testi-quote">"Ordered 36 salted caramel cupcakes for a corporate event. My inbox the following morning was full of messages asking for the bakery's name."</p>
        <div class="testi-author">
          <div class="testi-avatar">
            <img src="https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=80&q=80" alt="Priya Sharma" />
          </div>
          <div>
            <div class="testi-name">Priya Sharma</div>
            <div class="testi-role">Events Director</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ════════════════════════════════════════
     CTA BANNER
════════════════════════════════════════ -->
<div class="cta-banner">
  <div class="cta-banner-bg"></div>
  <div class="cta-banner-overlay"></div>
  <div class="cta-banner-content">
    <span class="eyebrow" style="display:block;margin-bottom:16px">Ready to Order?</span>
    <h2>Fresh Out of the Oven<br>and Into Your Home</h2>
    <p>Same-day delivery available. Free delivery on orders over Rs.3,000.00</p>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary" style="padding:15px 36px">
      Browse Full Menu
    </a>
  </div>
</div>

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
        <div class="soc-btn" title="Instagram">&#9678;</div>
        <div class="soc-btn" title="X">&#9678;</div>
        <div class="soc-btn" title="LinkedIn">&#9678;</div>
        <div class="soc-btn" title="YouTube">&#9678;</div>
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

  // Hero image zoom on load
  const heroBg = document.querySelector('.hero-bg');
  if (heroBg) setTimeout(() => heroBg.classList.add('loaded'), 100);

  // Scroll reveal
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) { e.target.classList.add('visible'); observer.unobserve(e.target); }
    });
  }, { threshold: 0.1 });
  document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const t = document.querySelector(a.getAttribute('href'));
      if (t) { e.preventDefault(); t.scrollIntoView({ behavior: 'smooth' }); }
    });
  });
</script>

</body>
</html>

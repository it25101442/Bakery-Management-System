<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activePage" value="menu" />
<c:set var="isAdmin" value="${sessionScope.isAdmin}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Menu — Crust &amp; Co.</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
  <style>
    /* ── Admin Panel ── */
    .admin-panel {
      background: #1a1a2e;
      border: 1px solid var(--gold, #c9a84c);
      border-radius: 12px;
      padding: 32px;
      margin: 32px 0;
    }
    .admin-panel h2 {
      color: var(--gold, #c9a84c);
      margin-bottom: 24px;
      font-size: 1.2rem;
      letter-spacing: 0.05em;
      text-transform: uppercase;
    }
    .admin-form {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
    }
    .admin-form .full-width { grid-column: 1 / -1; }
    .admin-form input,
    .admin-form select,
    .admin-form textarea {
      width: 100%;
      padding: 10px 14px;
      background: #0d0d1a;
      border: 1px solid #333;
      border-radius: 8px;
      color: #fff;
      font-size: 0.85rem;
      box-sizing: border-box;
    }
    .admin-form label {
      display: block;
      color: #aaa;
      font-size: 0.75rem;
      margin-bottom: 6px;
    }
    .admin-form textarea { resize: vertical; min-height: 80px; }
    .admin-actions { display: flex; gap: 12px; margin-top: 8px; }
    .btn-admin-save {
      background: var(--gold, #c9a84c);
      color: #000;
      border: none;
      padding: 10px 28px;
      border-radius: 8px;
      font-weight: 700;
      cursor: pointer;
      font-size: 0.85rem;
    }
    .btn-admin-clear {
      background: transparent;
      color: #aaa;
      border: 1px solid #444;
      padding: 10px 20px;
      border-radius: 8px;
      cursor: pointer;
      font-size: 0.85rem;
    }
    .btn-edit {
      background: #2a2a4a;
      color: var(--gold, #c9a84c);
      border: 1px solid var(--gold, #c9a84c);
      padding: 6px 14px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 0.75rem;
      margin-right: 6px;
    }
    .btn-delete {
      background: #4a1a1a;
      color: #e55;
      border: 1px solid #e55;
      padding: 6px 14px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 0.75rem;
    }
    .admin-badge {
      display: inline-block;
      background: var(--gold, #c9a84c);
      color: #000;
      font-size: 0.65rem;
      font-weight: 700;
      padding: 2px 8px;
      border-radius: 4px;
      margin-left: 8px;
      vertical-align: middle;
    }
    .toast {
      position: fixed; bottom: 24px; right: 24px;
      background: #1a1a2e; border: 1px solid var(--gold, #c9a84c);
      color: #fff; padding: 14px 24px; border-radius: 10px;
      font-size: 0.85rem; z-index: 9999; display: none;
    }
  </style>
</head>
<body>

<!-- ════ NAVIGATION ════ -->
<nav class="navbar">
  <a href="${pageContext.request.contextPath}/" class="nav-logo">
    <div class="logo-mark">C</div>
    <span class="logo-text">Crust &amp; Co.</span>
  </a>
  <ul class="nav-links">
    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
    <li><a href="${pageContext.request.contextPath}/products" class="active">Menu</a></li>
    <li>
      <a href="${pageContext.request.contextPath}/cart" class="nav-cart">
        Cart <span class="cart-badge" id="cartBadge" style="display:none">0</span>
      </a>
    </li>
    <c:choose>
      <c:when test="${not empty sessionScope.loggedInUser}">
        <li><span style="color:var(--gold);font-size:0.75rem;font-weight:600;">
          Hi, ${sessionScope.loggedInUser.name}
          <c:if test="${isAdmin}"><span class="admin-badge">ADMIN</span></c:if>
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

<!-- ════ PAGE HEADER ════ -->
<div class="page-header">
  <div class="container">
    <span class="eyebrow">Our Offerings</span>
    <h1>The Full Menu</h1>
    <p>Every item is baked fresh each morning — made by hand with premium ingredients and no shortcuts.</p>
  </div>
</div>

<main class="container">

  <!-- ════ ADMIN PANEL (visible only to admin) ════ -->
  <c:if test="${isAdmin}">
  <div class="admin-panel">
    <h2>&#9998; Product Management</h2>
    <form class="admin-form" id="productForm">
      <input type="hidden" id="productId" />
      <div>
        <label>Product Name *</label>
        <input type="text" id="pName" placeholder="e.g. Chocolate Fudge Cake" required />
      </div>
      <div>
        <label>Category *</label>
        <select id="pCategory">
          <option value="cakes">Cakes</option>
          <option value="bread">Breads</option>
          <option value="cupcakes">Cupcakes</option>
          <option value="pastries">Pastries</option>
          <option value="donuts">Donuts</option>
        </select>
      </div>
      <div>
        <label>Price (Rs.) *</label>
        <input type="number" id="pPrice" placeholder="0.00" step="0.01" min="0" required />
      </div>
      <div>
        <label>Image URL</label>
        <input type="text" id="pImageUrl" placeholder="https://..." />
      </div>
      <div class="full-width">
        <label>Description</label>
        <textarea id="pDescription" placeholder="Describe the product..."></textarea>
      </div>
      <div class="full-width admin-actions">
        <button type="button" class="btn-admin-save" onclick="saveProduct()">Save Product</button>
        <button type="button" class="btn-admin-clear" onclick="clearForm()">Clear</button>
      </div>
    </form>
  </div>
  </c:if>

  <!-- ════ FILTER BAR ════ -->
  <div class="filter-row">
    <span class="filter-lbl">Filter</span>
    <a href="${pageContext.request.contextPath}/products"
       class="filter-btn <c:if test='${empty selectedCat || selectedCat == "all"}'>active</c:if>">All Items</a>
    <a href="${pageContext.request.contextPath}/products?cat=cakes"
       class="filter-btn <c:if test='${selectedCat == "cakes"}'>active</c:if>">Cakes</a>
    <a href="${pageContext.request.contextPath}/products?cat=bread"
       class="filter-btn <c:if test='${selectedCat == "bread"}'>active</c:if>">Breads</a>
    <a href="${pageContext.request.contextPath}/products?cat=cupcakes"
       class="filter-btn <c:if test='${selectedCat == "cupcakes"}'>active</c:if>">Cupcakes</a>
    <a href="${pageContext.request.contextPath}/products?cat=pastries"
       class="filter-btn <c:if test='${selectedCat == "pastries"}'>active</c:if>">Pastries</a>
    <a href="${pageContext.request.contextPath}/products?cat=donuts"
       class="filter-btn <c:if test='${selectedCat == "donuts"}'>active</c:if>">Donuts</a>
  </div>

  <!-- ════ PRODUCT GRID ════ -->
  <div class="products-grid" id="productsGrid">
    <c:choose>
      <c:when test="${not empty products}">
        <c:forEach var="p" items="${products}">
          <div class="product-card" data-category="${p.category}" id="card-${p.id}">
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
                <c:choose>
                  <c:when test="${isAdmin}">
                    <button class="btn-edit"
                      onclick="editProduct(${p.id},'${p.name}','${p.category}',${p.price},'${p.imageUrl}','${p.description}')">
                      Edit
                    </button>
                    <button class="btn-delete" onclick="deleteProduct(${p.id})">Delete</button>
                  </c:when>
                  <c:otherwise>
                    <button class="atc-btn add-to-cart"
                            data-id="${p.id}"
                            data-name="${p.name}"
                            data-price="${p.price}">Add to Cart</button>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div style="grid-column:1/-1;text-align:center;padding:80px 0;">
          <p style="color:var(--text-secondary);font-size:0.88rem;">No items found in this category.</p>
          <a href="${pageContext.request.contextPath}/products" class="btn btn-outline" style="margin-top:24px;">View All Items</a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

</main>

<!-- ════ FOOTER ════ -->
<footer>
  <div class="footer-top container">
    <div class="footer-brand">
      <a href="${pageContext.request.contextPath}/" class="nav-logo">
        <div class="logo-mark">C</div>
        <span class="logo-text">Crust &amp; Co.</span>
      </a>
      <p>Artisan baked goods crafted with devotion and the world's finest ingredients. Baking joy since 1987.</p>
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
      <a href="#">Contact</a>
    </div>
  </div>
  <div class="footer-bottom container">
    <span>&copy; 2026 Crust &amp; Co. All rights reserved.</span>
    <span>Privacy Policy &nbsp;&middot;&nbsp; Terms &nbsp;&middot;&nbsp; Cookies</span>
  </div>
</footer>

<div class="toast" id="toast"></div>

<script src="${pageContext.request.contextPath}/js/cart.js"></script>
<script>
  const ctx = '${pageContext.request.contextPath}';

  function showToast(msg) {
    const t = document.getElementById('toast');
    t.textContent = msg;
    t.style.display = 'block';
    setTimeout(() => t.style.display = 'none', 3000);
  }

  function clearForm() {
    document.getElementById('productId').value = '';
    document.getElementById('pName').value = '';
    document.getElementById('pCategory').value = 'cakes';
    document.getElementById('pPrice').value = '';
    document.getElementById('pImageUrl').value = '';
    document.getElementById('pDescription').value = '';
  }

  function editProduct(id, name, category, price, imageUrl, description) {
    document.getElementById('productId').value = id;
    document.getElementById('pName').value = name;
    document.getElementById('pCategory').value = category;
    document.getElementById('pPrice').value = price;
    document.getElementById('pImageUrl').value = imageUrl;
    document.getElementById('pDescription').value = description;
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  async function saveProduct() {
    const id = document.getElementById('productId').value;
    const body = {
      name:        document.getElementById('pName').value,
      category:    document.getElementById('pCategory').value,
      price:       parseFloat(document.getElementById('pPrice').value),
      imageUrl:    document.getElementById('pImageUrl').value,
      description: document.getElementById('pDescription').value
    };
    if (!body.name || !body.price) { showToast('Name and price are required.'); return; }

    const url    = id ? ctx + '/api/products/' + id : ctx + '/api/products';
    const method = id ? 'PUT' : 'POST';

    const res = await fetch(url, {
      method,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body)
    });
    if (res.ok) {
      showToast(id ? 'Product updated!' : 'Product added!');
      clearForm();
      setTimeout(() => location.reload(), 1000);
    } else {
      showToast('Error saving product.');
    }
  }

  async function deleteProduct(id) {
    if (!confirm('Delete this product?')) return;
    const res = await fetch(ctx + '/api/products/' + id, { method: 'DELETE' });
    if (res.ok) {
      document.getElementById('card-' + id).remove();
      showToast('Product deleted.');
    } else {
      showToast('Error deleting product.');
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

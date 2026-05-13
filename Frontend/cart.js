/**
 * cart.js — Crust & Co.
 * Handles: add to cart, cart page rendering, checkout summary, badge updates
 */

const CART_KEY          = 'cc_cart';
const DELIVERY_FEE      = 500.00;
const TAX_RATE          = 0.08;
const FREE_DELIVERY_MIN = 5000;

/* ── Get / Save cart ─────────────────────────────────────────── */
function getCart() {
  try { return JSON.parse(localStorage.getItem(CART_KEY) || '[]'); }
  catch(e) { return []; }
}

function saveCart(cart) {
  localStorage.setItem(CART_KEY, JSON.stringify(cart));
  updateCartBadge();
}

/* ── Format currency ─────────────────────────────────────────── */
function formatRs(amount) {
  return 'Rs.' + Number(amount).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

/* ── Update nav cart badge ───────────────────────────────────── */
function updateCartBadge() {
  const cart  = getCart();
  const count = cart.reduce((s, i) => s + i.qty, 0);
  document.querySelectorAll('.cart-badge').forEach(el => {
    el.textContent   = count;
    el.style.display = count > 0 ? 'flex' : 'none';
  });
}

/* ── Toast notification ──────────────────────────────────────── */
function showToast(msg) {
  let toast = document.getElementById('cc-toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'cc-toast';
    toast.style.cssText = `
      position:fixed;bottom:32px;right:32px;
      background:var(--ink-2,#1c1c1c);
      border:1px solid rgba(255,255,255,0.07);
      border-left:3px solid var(--gold,#c9954a);
      color:rgba(255,255,255,0.92);
      padding:14px 20px;border-radius:12px;
      font-size:0.82rem;font-weight:500;
      box-shadow:0 24px 80px rgba(0,0,0,0.7);
      z-index:10000;opacity:0;
      transform:translateX(120%);
      transition:all 0.3s cubic-bezier(0.4,0,0.2,1);
      max-width:320px;font-family:inherit;
    `;
    document.body.appendChild(toast);
  }
  toast.textContent      = msg;
  toast.style.opacity    = '1';
  toast.style.transform  = 'translateX(0)';
  clearTimeout(toast._t);
  toast._t = setTimeout(() => {
    toast.style.opacity   = '0';
    toast.style.transform = 'translateX(120%)';
  }, 2500);
}

/* ── Add to cart (called by product buttons) ─────────────────── */
function addToCart(id, name, price) {
  const cart     = getCart();
  const existing = cart.find(i => i.id == id);
  if (existing) {
    existing.qty += 1;
  } else {
    cart.push({ id: id, name: name, price: parseFloat(price), qty: 1 });
  }
  saveCart(cart);
  showToast(name + ' added to cart');
}

/* ── Listen for Add-to-Cart button clicks ────────────────────── */
document.addEventListener('click', function(e) {
  const btn = e.target.closest('.add-to-cart, .atc-btn');
  if (!btn) return;
  const id    = btn.dataset.id;
  const name  = btn.dataset.name;
  const price = btn.dataset.price;
  if (id && name && price) {
    addToCart(id, name, price);
  }
});

/* ── Calculate totals ────────────────────────────────────────── */
function calcTotals(cart) {
  const sub = cart.reduce((s, i) => s + i.price * i.qty, 0);
  const del = sub >= FREE_DELIVERY_MIN ? 0 : DELIVERY_FEE;
  const tax = sub * TAX_RATE;
  const tot = sub + del + tax;
  return { sub, del, tax, tot };
}

/* ── Update summary elements ─────────────────────────────────── */
function updateSummary(cart, ids) {
  const { sub, del, tax, tot } = calcTotals(cart);
  const count = cart.reduce((s, i) => s + i.qty, 0);

  if (ids.sub  && document.getElementById(ids.sub))   document.getElementById(ids.sub).textContent  = formatRs(sub);
  if (ids.del  && document.getElementById(ids.del))   document.getElementById(ids.del).textContent  = del === 0 ? 'Free' : formatRs(del);
  if (ids.tax  && document.getElementById(ids.tax))   document.getElementById(ids.tax).textContent  = formatRs(tax);
  if (ids.tot  && document.getElementById(ids.tot))   document.getElementById(ids.tot).textContent  = formatRs(tot);
  if (ids.count && document.getElementById(ids.count)) document.getElementById(ids.count).textContent = count + (count === 1 ? ' item' : ' items');
}

/* ════════════════════════════════════════════════════════════════
   CART PAGE
════════════════════════════════════════════════════════════════ */
function renderCartPage() {
  const wrap    = document.getElementById('cartItemsWrap');
  if (!wrap) return;

  const cart    = getCart();
  const emptyEl = document.getElementById('emptyCart');
  const layoutEl = document.getElementById('cartLayout');

  if (cart.length === 0) {
    if (emptyEl)  emptyEl.style.display  = 'block';
    if (layoutEl) layoutEl.style.display = 'none';
    return;
  }

  if (emptyEl)  emptyEl.style.display  = 'none';
  if (layoutEl) layoutEl.style.display = 'grid';

  wrap.innerHTML = cart.map(item => `
    <div class="cart-item" data-id="${item.id}">
      <div class="ci-img" style="background:var(--ink-3,#262626);display:flex;align-items:center;justify-content:center;">
        <span style="font-size:1.6rem;">&#127859;</span>
      </div>
      <div>
        <div class="ci-name">${escHtml(item.name)}</div>
        <div class="ci-cat">Artisan Bake</div>
        <div class="qty-row">
          <button class="qty-btn" onclick="cartDecQty('${item.id}')">&#8722;</button>
          <span class="qty-val">${item.qty}</span>
          <button class="qty-btn" onclick="cartIncQty('${item.id}')">&#43;</button>
        </div>
      </div>
      <div class="ci-right">
        <div class="ci-price">${formatRs(item.price * item.qty)}</div>
        <button class="ci-remove" onclick="cartRemove('${item.id}')">Remove</button>
      </div>
    </div>
  `).join('');

  updateSummary(cart, {
    sub: 'csSub', del: 'csDel', tax: 'csTax', tot: 'csTot', count: 'cartCountLbl'
  });
}

/* ── Cart page actions ───────────────────────────────────────── */
window.cartIncQty = function(id) {
  const cart = getCart();
  const item = cart.find(i => i.id == id);
  if (item) { item.qty += 1; saveCart(cart); renderCartPage(); }
};

window.cartDecQty = function(id) {
  const cart = getCart();
  const item = cart.find(i => i.id == id);
  if (item) {
    item.qty -= 1;
    if (item.qty <= 0) cart.splice(cart.indexOf(item), 1);
    saveCart(cart);
    renderCartPage();
    showToast(item.qty <= 0 ? 'Item removed' : 'Quantity updated');
  }
};

window.cartRemove = function(id) {
  const cart = getCart().filter(i => i.id != id);
  saveCart(cart);
  showToast('Item removed from cart');
  renderCartPage();
};

/* ════════════════════════════════════════════════════════════════
   CHECKOUT PAGE
════════════════════════════════════════════════════════════════ */
function renderCheckoutSummary() {
  const listEl = document.getElementById('coItemsList');
  if (!listEl) return;

  const cart = getCart();
  if (cart.length === 0) {
    listEl.innerHTML = '<p style="font-size:.82rem;color:var(--text-secondary);padding:4px 0">Your cart is empty.</p>';
  } else {
    listEl.innerHTML = cart.map(i => `
      <div class="co-item">
        <div class="co-item-img"
             style="background:var(--ink-3,#262626);display:flex;align-items:center;justify-content:center;">
          <span style="font-size:1.2rem;">&#127859;</span>
        </div>
        <div style="flex:1;">
          <div class="co-item-name">${escHtml(i.name)}</div>
          <div class="co-item-qty">&times;${i.qty}</div>
        </div>
        <div class="co-item-price">${formatRs(i.price * i.qty)}</div>
      </div>
    `).join('');
  }

  updateSummary(cart, {
    sub: 'coSub', del: 'coDel', tax: 'coTax', tot: 'coTot'
  });
}

/* ── Populate hidden fields before checkout form submit ──────── */
function initCheckoutForm() {
  const form = document.getElementById('checkoutForm');
  if (!form) return;

  renderCheckoutSummary();

  form.addEventListener('submit', function() {
    const cart = getCart();
    const cartInput  = document.getElementById('cartItemsInput');
    const totalInput = document.getElementById('totalInput');
    if (cartInput)  cartInput.value  = JSON.stringify(cart);
    if (totalInput) {
      const { tot } = calcTotals(cart);
      totalInput.value = tot.toFixed(2);
    }
  });
}

/* ── Simple HTML escape ──────────────────────────────────────── */
function escHtml(str) {
  if (!str) return '';
  return str.replace(/[&<>"']/g, m => ({
    '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'
  }[m]));
}

/* ── Init on DOM ready ───────────────────────────────────────── */
document.addEventListener('DOMContentLoaded', function() {
  updateCartBadge();
  renderCartPage();
  initCheckoutForm();
});

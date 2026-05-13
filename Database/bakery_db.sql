-- ================================================================
-- CRUST & CO. — Fresh Database Setup
-- Run this entire script in MySQL Workbench
-- ================================================================

-- Drop and recreate database (clean start)
DROP DATABASE IF EXISTS bakery_db;
CREATE DATABASE bakery_db;
USE bakery_db;

-- ── Customer table ───────────────────────────────────────────────
CREATE TABLE customer (
    id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100)        NOT NULL,
    email    VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255)        NOT NULL
);

-- ── Product table ────────────────────────────────────────────────
CREATE TABLE product (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150)   NOT NULL,
    description TEXT,
    category    VARCHAR(50),
    price       DOUBLE         NOT NULL,
    image_url   VARCHAR(500),
    badge       VARCHAR(50)
);

-- ── Orders table ─────────────────────────────────────────────────
CREATE TABLE orders (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_name  VARCHAR(100),
    email          VARCHAR(150),
    phone          VARCHAR(20),
    address        VARCHAR(255),
    city           VARCHAR(100),
    zip            VARCHAR(20),
    state          VARCHAR(100),
    delivery       VARCHAR(20),
    payment        VARCHAR(20),
    notes          TEXT,
    items          TEXT,
    total          DOUBLE
);

-- ── Custom cake table ────────────────────────────────────────────
CREATE TABLE custom_cake (
    id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    design  VARCHAR(255),
    message VARCHAR(255)
);

-- ── Products with unique images ──────────────────────────────────
INSERT INTO product (name, description, category, price, image_url, badge) VALUES
(
  'Chocolate Fudge Cake',
  'Rich dark chocolate layers with ganache frosting',
  'cakes', 2500.00,
  'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600&q=80',
  'Popular'
),
(
  'Red Velvet Cake',
  'Classic red velvet with cream cheese frosting',
  'cakes', 2800.00,
  'http://maverickbaking.com/wp-content/uploads/2016/07/DSC02899.jpg',
  'Bestseller'
),
(
  'Sourdough Loaf',
  'Traditional sourdough with crispy crust',
  'bread', 850.00,
  'https://tse2.mm.bing.net/th/id/OIP.bU0v19fuBucF5is0epiG_wHaE7?pid=Api&h=220&P=0',
  'Fresh'
),
(
  'Multigrain Bread',
  'Hearty multigrain loaf packed with seeds',
  'bread', 950.00,
  'https://recipes.net/wp-content/uploads/2023/05/gluten-free-multigrain-bread-recipe_7f1b7517241661b5e91ba9d8bdd66094.jpeg',
  NULL
),
(
  'Vanilla Cupcake',
  'Fluffy vanilla with buttercream swirl',
  'cupcakes', 350.00,
  'https://images.unsplash.com/photo-1576618148400-f54bed99fcfd?w=600&q=80',
  NULL
),
(
  'Chocolate Cupcake',
  'Double chocolate cupcake with chocolate ganache',
  'cupcakes', 380.00,
  'https://www.pequerecetas.com/wp-content/uploads/2022/10/cupcakes-de-chococolate-con-ganache-de-chocolate.jpg',
  'Popular'
),
(
  'Butter Croissant',
  'Flaky golden croissant baked fresh every morning',
  'pastries', 450.00,
  'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=600&q=80',
  'Fresh'
),
(
  'Almond Danish',
  'Buttery danish pastry filled with almond cream',
  'pastries', 480.00,
  'https://therecipeshome.com/wp-content/uploads/2025/08/0_2-1754489646552.webp',
  NULL
),
(
  'Glazed Donut',
  'Classic glazed donut, light and fluffy',
  'donuts', 280.00,
  'https://sallysbakingaddiction.com/wp-content/uploads/2014/09/baked-maple-glazed-donuts-2.jpg',
  NULL
),
(
  'Chocolate Sprinkle Donut',
  'Chocolate frosted donut with rainbow sprinkles',
  'donuts', 320.00,
  'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=600&q=80',
  'Popular'
);

-- ── Verify results ───────────────────────────────────────────────
SELECT id, name, category, price, image_url, badge FROM product;

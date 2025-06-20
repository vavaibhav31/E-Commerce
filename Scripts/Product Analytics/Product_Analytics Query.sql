--II. PRODUCT ANALYTICS

--Basic

--1. Top reviewed products
SELECT 
  product_name, COUNT(*) AS review_count
FROM Product_Reviews pr
JOIN Products p ON pr.product_id = p.product_id
GROUP BY product_name
ORDER BY review_count DESC;
----------------------------------------------------------------------
--2. Avg rating by category
SELECT 
  c.category_name, AVG(r.rating) AS avg_rating
FROM Product_Reviews r
JOIN Products p ON r.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.category_name;
------------------------------------------------------------------------
--Intermediate

--1. Review trends over time
SELECT 
  FORMAT(review_date, 'yyyy-MM') AS month, COUNT(*) AS reviews
FROM Product_Reviews
GROUP BY FORMAT(review_date, 'yyyy-MM')
ORDER BY month;
-----------------------------------------------------------------------------
--2. Sentiment breakdown by category
SELECT 
  c.category_name,
  SUM(CASE WHEN r.review_text LIKE '%good%' THEN 1 ELSE 0 END) AS positive,
  SUM(CASE WHEN r.review_text LIKE '%bad%' THEN 1 ELSE 0 END) AS negative
FROM Product_Reviews r
JOIN Products p ON r.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.category_name;
-------------------------------------------------------------------------------
--3. Repeat purchases by product
SELECT 
  p.product_name, COUNT(DISTINCT o.customer_id) AS repeat_customers
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
HAVING COUNT(DISTINCT o.customer_id) > 1;
------------------------------------------------------------------------------
--Advanced

--1. Return rate vs average rating
SELECT 
  p.product_name, 
  AVG(r.rating) AS avg_rating, 
  COUNT(rt.return_id) AS return_count
FROM Product_Reviews r
JOIN Products p ON r.product_id = p.product_id
JOIN Order_Items oi ON p.product_id = oi.product_id
LEFT JOIN Returns rt ON oi.order_item_id = rt.order_item_id
GROUP BY p.product_name
HAVING COUNT(rt.return_id) > 0;
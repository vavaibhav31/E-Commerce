--CUSTOMER ANALYTICS

--Basic

--1. Repeat vs one-time customers
WITH CustomerOrders AS (
  SELECT customer_id, COUNT(order_id) AS order_count
  FROM Orders
  GROUP BY customer_id
)
SELECT 
  CASE WHEN order_count > 1 THEN 'Repeat' ELSE 'One-time' END AS customer_type,
  COUNT(*) AS customer_count
FROM CustomerOrders
GROUP BY CASE WHEN order_count > 1 THEN 'Repeat' ELSE 'One-time' END;
------------------------------------------------------------------------
--2.  Inactive but High-Value SELECT 
    SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_spent,
    MAX(o.order_date) AS last_order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING MAX(o.order_date) < DATEADD(DAY, -90, GETDATE())
ORDER BY total_spent DESC;
------------------------------------------------------------------------
--Intermediate

--1. Avg days between purchases
SELECT customer_id, AVG(DATEDIFF(DAY, prev_order, curr_order)) AS avg_gap
FROM (
  SELECT customer_id, order_date AS curr_order,
         LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_order
  FROM Orders
) t
WHERE prev_order IS NOT NULL
GROUP BY customer_id;
--------------------------------------------------------------------------
--2. Churn by region
WITH LastOrders AS (
  SELECT customer_id, MAX(order_date) AS last_order
  FROM Orders
  GROUP BY customer_id
)
SELECT 
  r.region_name,
  COUNT(c.customer_id) AS total_customers,
  COUNT(CASE WHEN lo.last_order < DATEADD(DAY, -90, GETDATE()) THEN 1 END) AS churned_customers
FROM Customers c
JOIN Address a ON c.address_id = a.address_id
JOIN Regions r ON a.region_id = r.region_id
LEFT JOIN LastOrders lo ON c.customer_id = lo.customer_id
GROUP BY r.region_name;
------------------------------------------------------------------------------
--Advanced

--1. Churned high-value customers
SELECT o.customer_id, SUM(p.amount) AS total_spent
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id
WHERE o.customer_id IN (
    SELECT customer_id
    FROM Orders
    GROUP BY customer_id
    HAVING MAX(order_date) < DATEADD(DAY, -90, GETDATE())
)
GROUP BY o.customer_id
ORDER BY total_spent DESC;
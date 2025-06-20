--I. FINANCE

--Basic

--1. Total revenue generated per month
SELECT 
    FORMAT(payment_date, 'yyyy-MM') AS month,
    SUM(amount) AS total_revenue
FROM Payments
GROUP BY FORMAT(payment_date, 'yyyy-MM')
ORDER BY month;
---------------------------------------------
--2. Orders paid by each payment mode
SELECT 
    payment_method,
    COUNT(*) AS payment_count
FROM Payments
GROUP BY payment_method;
----------------------------------------------
--3. Average Order Value (AOV) by region
SELECT 
    r.region_name, 
    AVG(p.amount) AS avg_order_value
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
JOIN Address a ON o.shipping_address_id = a.address_id
JOIN Regions r ON a.region_id = r.region_id
GROUP BY r.region_name;
---------------------------------------------------
--Intermediate

--1. Net profit per region (Revenue - Refunds) using CTE
WITH RegionalRevenue AS (
  SELECT 
    r.region_name, 
    SUM(p.amount) AS revenue
  FROM Payments p
  JOIN Orders o ON p.order_id = o.order_id
  JOIN Address a ON o.shipping_address_id = a.address_id
  JOIN Regions r ON a.region_id = r.region_id
  GROUP BY r.region_name
),
RegionalRefunds AS (
  SELECT 
    r.region_name, 
    SUM(ret.refund_amount) AS refunds
  FROM Returns ret
  JOIN Order_Items oi ON ret.order_item_id = oi.order_item_id
  JOIN Orders o ON oi.order_id = o.order_id
  JOIN Address a ON o.shipping_address_id = a.address_id
  JOIN Regions r ON a.region_id = r.region_id
  GROUP BY r.region_name
)
SELECT 
  rr.region_name,
  rr.revenue - COALESCE(rf.refunds, 0) AS net_profit
FROM RegionalRevenue rr
LEFT JOIN RegionalRefunds rf ON rr.region_name = rf.region_name;
--------------------------------------------------------------
--2. Top 5 profit margin sellers using window
SELECT seller_id, seller_name, profit
FROM (
  SELECT 
    s.seller_id, 
    s.seller_name, 
    SUM(oi.unit_price * oi.quantity - pr.cost * oi.quantity) AS profit,
    RANK() OVER (ORDER BY SUM(oi.unit_price * oi.quantity - pr.cost * oi.quantity) DESC) AS rnk
  FROM Order_Items oi
  JOIN Products pr ON oi.product_id = pr.product_id
  JOIN Sellers s ON pr.seller_id = s.seller_id
  GROUP BY s.seller_id, s.seller_name
) sub
WHERE rnk <= 5;
-------------------------------------------------------------------
--Advanced

--1. Products with negative margin
SELECT 
  pr.product_id, pr.product_name,
  SUM(oi.unit_price * oi.quantity) - SUM(pr.cost * oi.quantity) AS margin
FROM Order_Items oi
JOIN Products pr ON oi.product_id = pr.product_id
GROUP BY pr.product_id, pr.product_name
HAVING SUM(oi.unit_price * oi.quantity) - SUM(pr.cost * oi.quantity) < 0;
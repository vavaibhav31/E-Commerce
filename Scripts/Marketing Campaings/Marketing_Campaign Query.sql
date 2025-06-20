--MARKETING CAMPAIGN PERFORMANCE

--Basic

--1. Campaigns with highest revenue
SELECT mc.campaign_name, SUM(p.amount) AS total_revenue
FROM Marketing_Campaigns mc
JOIN Products pr ON mc.product_id = pr.product_id
JOIN Order_Items oi ON pr.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY mc.campaign_name
ORDER BY total_revenue DESC;
-----------------------------------------------------------------------------------
--Intermediate

--1. Avg order value by campaign
SELECT mc.campaign_name, AVG(p.amount) AS avg_order_value
FROM Marketing_Campaigns mc
JOIN Products pr ON mc.product_id = pr.product_id
JOIN Order_Items oi ON pr.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY mc.campaign_name;
-----------------------------------------------------------------------------------
--Advanced

--1. Avg days from campaign start to order
SELECT mc.campaign_name, 
       AVG(DATEDIFF(DAY, mc.start_date, o.order_date)) AS avg_days_to_order
FROM Marketing_Campaigns mc
JOIN Products pr ON mc.product_id = pr.product_id
JOIN Order_Items oi ON pr.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
GROUP BY mc.campaign_name;
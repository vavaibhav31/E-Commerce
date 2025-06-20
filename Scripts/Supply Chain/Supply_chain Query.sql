--V. SUPPLY CHAIN

--Basic

--1. Avg delivery time by region
SELECT r.region_name, 
       AVG(DATEDIFF(DAY, o.order_date, s.delivery_date)) AS avg_delivery_days
FROM Shipments s
JOIN Orders o ON s.order_id = o.order_id
JOIN Address a ON o.shipping_address_id = a.address_id
JOIN Regions r ON a.region_id = r.region_id
GROUP BY r.region_name;
------------------------------------------------------------------------------------
--Intermediate

--1. Return rate by region
SELECT r.region_name, 
       COUNT(rt.return_id) * 1.0 / COUNT(DISTINCT o.order_id) AS return_rate
FROM Returns rt
JOIN Order_Items oi ON rt.order_item_id = oi.order_item_id
JOIN Orders o ON oi.order_id = o.order_id
JOIN Address a ON o.shipping_address_id = a.address_id
JOIN Regions r ON a.region_id = r.region_id
GROUP BY r.region_name;
------------------------------------------------------------------------------
--2. Fulfillment time by seller
SELECT s.seller_id, s.seller_name, 
       AVG(DATEDIFF(DAY, o.order_date, sh.shipment_date)) AS avg_fulfillment_days
FROM Orders o
JOIN Shipments sh ON o.order_id = sh.order_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
JOIN Sellers s ON p.seller_id = s.seller_id
GROUP BY s.seller_id, s.seller_name;
-----------------------------------------------------------------------------------
--Advanced

--1. Products Below Reorder Threshold by Category
SELECT 
    c.category_name,
    COUNT(*) AS low_stock_count
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
WHERE i.stock_level <= 20 
GROUP BY c.category_name
ORDER BY low_stock_count DESC;
--------------------------------------------------------------------------------
--2. Lead Time for Valid Deliveries Only
SELECT 
    p.product_name,
    AVG(DATEDIFF(DAY, i.last_updated, s.delivery_date)) AS avg_lead_time
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
JOIN Shipments s ON o.order_id = s.order_id
WHERE s.delivery_date > i.last_updated  
GROUP BY p.product_name
ORDER BY avg_lead_time DESC;
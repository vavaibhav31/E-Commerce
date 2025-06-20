--VI. CUSTOMER EXPERIENCE

--Basic

--1. Average rating per seller
SELECT s.seller_id, s.seller_name, AVG(r.rating) AS avg_rating
FROM Product_Reviews r
JOIN Products p ON r.product_id = p.product_id
JOIN Sellers s ON p.seller_id = s.seller_id
GROUP BY s.seller_id, s.seller_name;
--------------------------------------------------------------------------------
--Intermediate

--1. Support-Related Reviews by Category
SELECT 
    c.category_name,
    COUNT(*) AS support_related_reviews
FROM Product_Reviews pr
JOIN Products p ON pr.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
WHERE pr.review_text LIKE '%not%' 
   OR pr.review_text LIKE '%no%' 
   OR pr.review_text LIKE '%delay%' 
   OR pr.review_text LIKE '%damaged%' 
   OR pr.review_text LIKE '%wrong%' 
   OR pr.review_text LIKE '%bad%' 
   OR pr.review_text LIKE '%poor%' 
GROUP BY c.category_name
ORDER BY support_related_reviews DESC;
--------------------------------------------------------------------------------------
--Advanced

--1.  Average Rating vs Return Rate by Product
SELECT 
    p.product_name,
    AVG(CAST(pr.rating AS FLOAT)) AS avg_rating,
    COUNT(DISTINCT r.return_id) * 100.0 / NULLIF(COUNT(DISTINCT oi.order_item_id), 0) AS return_rate_pct
FROM Products p
JOIN Product_Reviews pr ON p.product_id = pr.product_id
JOIN Order_Items oi ON p.product_id = oi.product_id
LEFT JOIN Returns r ON oi.order_item_id = r.order_item_id
GROUP BY p.product_name
HAVING COUNT(pr.review_id) >= 5
ORDER BY return_rate_pct DESC;
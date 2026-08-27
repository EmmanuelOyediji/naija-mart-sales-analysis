-- ==========================================
-- Naija Mart Sales Analysis — SQL Section
-- ==========================================

-- Q1: Which branch generates the most revenue?
SELECT 
    b.branch_name,
    b.city,
    ROUND(SUM(t.quantity * p.unit_price * (1 - COALESCE(t.discount_pct, 0) / 100.0)), 2) AS total_revenue
FROM transactions AS t
JOIN branches AS b
    ON t.branch_id = b.branch_id
JOIN products AS p
    ON t.product_id = p.product_id
GROUP BY b.branch_name, b.city
ORDER BY total_revenue DESC;


-- Q2: Which product category has the highest total discount given, and does that match where the most revenue comes from?
SELECT 
    p.category,
    ROUND(SUM(t.quantity * p.unit_price * (COALESCE(t.discount_pct, 0) / 100.0)), 2) AS total_discount_given,
    ROUND(SUM(t.quantity * p.unit_price * (1 - COALESCE(t.discount_pct, 0) / 100.0)), 2) AS total_revenue
FROM transactions AS t
JOIN products AS p
    ON t.product_id = p.product_id
GROUP BY p.category
ORDER BY total_discount_given DESC;


-- Q3: What's the average order value per branch?
SELECT 
    b.branch_name,
    b.city,
    COUNT(t.transaction_id) AS total_orders,
    ROUND(AVG(t.quantity * p.unit_price * (1 - COALESCE(t.discount_pct, 0) / 100.0)), 2) AS avg_order_value
FROM transactions AS t
JOIN branches AS b
    ON t.branch_id = b.branch_id
JOIN products AS p
    ON t.product_id = p.product_id
GROUP BY b.branch_name, b.city
ORDER BY avg_order_value DESC;
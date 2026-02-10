/* Project: E-Commerce Sales Analysis
Database: PostgreSQL
Goal: Extract key insights on revenue and customer retention.
*/

-- 1. Calculate Monthly Revenue Growth
-- Helps identify seasonal trends (e.g., high sales in December)
SELECT 
    DATE_TRUNC('month', order_date) AS sales_month,
    SUM(total_amount) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1 DESC;

-- 2. Identify High-Value Customers (VIPs) for Loyalty Program
-- Logic: Customers who spent more than $5000 in the last year
SELECT 
    c.customer_name,
    c.email,
    SUM(o.total_amount) AS lifetime_value,
    COUNT(o.order_id) as purchase_frequency
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2024-01-01'
GROUP BY c.customer_name, c.email
HAVING SUM(o.total_amount) > 5000
ORDER BY lifetime_value DESC;

-- 3. Detect Churned Customers
-- Logic: Customers who haven't purchased in the last 6 months
SELECT 
    c.customer_id, 
    c.customer_name,
    MAX(o.order_date) as last_purchase_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING MAX(o.order_date) < CURRENT_DATE - INTERVAL '6 months';

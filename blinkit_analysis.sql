
-- 1. Total Sales by Product Category
SELECT 
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM blinkit_order_items oi
JOIN blinkit_products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- 2. Average Order Value by Customer Segment
SELECT 
    c.customer_segment,
    ROUND(AVG(o.order_total), 2) AS avg_order_value
FROM blinkit_orders o
JOIN blinkit_customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_segment;

-- 3. Number of Orders by Payment Method
SELECT 
    payment_method,
    COUNT(order_id) AS total_orders
FROM blinkit_orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- 4. Top 5 Selling Products by Quantity
SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM blinkit_order_items oi
JOIN blinkit_products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- 5. Monthly New Customer Registrations
SELECT 
    DATE_TRUNC('month', registration_date) AS reg_month,
    COUNT(customer_id) AS new_customers
FROM blinkit_customers
GROUP BY reg_month
ORDER BY reg_month;

-- 6. Orders That Were Delayed in Delivery
SELECT 
    o.order_id,
    o.promised_delivery_time,
    o.actual_delivery_time,
    dp.reasons_if_delayed
FROM blinkit_orders o
JOIN blinkit_delivery_performance dp ON o.order_id = dp.order_id
WHERE o.delivery_status = 'Delayed';

-- 7. Campaign Performance Metrics
SELECT 
    campaign_name,
    impressions,
    clicks,
    conversions,
    ROUND(spend, 2) AS spend,
    ROUND(revenue_generated, 2) AS revenue,
    ROUND(roas, 2) AS return_on_ad_spend
FROM blinkit_marketing_performance
ORDER BY roas DESC;

-- 8. Inventory Health Check
SELECT 
    i.product_id,
    p.product_name,
    SUM(i.stock_received) AS total_stock,
    SUM(i.damaged_stock) AS total_damaged
FROM blinkit_inventory i
JOIN blinkit_products p ON i.product_id = p.product_id
GROUP BY i.product_id, p.product_name
ORDER BY total_stock DESC;

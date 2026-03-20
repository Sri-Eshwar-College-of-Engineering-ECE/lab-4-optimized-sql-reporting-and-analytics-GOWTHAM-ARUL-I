-- Create simplified tables for analytics
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(200),
    category VARCHAR(100),
    brand VARCHAR(100),
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    age INT,
    gender VARCHAR(20),
    city VARCHAR(100),
    signup_date DATE,
    membership_level VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(50)
);

CREATE TABLE order_details (
    detail_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2)
);

-- Insert sample data
INSERT INTO products VALUES
    (1, 'iPhone 15', 'Electronics', 'Apple', 999.99, 700.00),
    (2, 'Galaxy S24', 'Electronics', 'Samsung', 899.99, 600.00),
    (3, 'MacBook Pro', 'Electronics', 'Apple', 1999.99, 1400.00),
    (4, 'Nike Air Max', 'Footwear', 'Nike', 129.99, 70.00),
    (5, 'Adidas Ultraboost', 'Footwear', 'Adidas', 149.99, 80.00),
    (6, 'Sony Headphones', 'Electronics', 'Sony', 199.99, 120.00),
    (7, 'Levi Jeans', 'Clothing', 'Levi', 79.99, 35.00),
    (8, 'Zara Shirt', 'Clothing', 'Zara', 39.99, 15.00),
    (9, 'Dell Monitor', 'Electronics', 'Dell', 299.99, 200.00),
    (10, 'Puma Shoes', 'Footwear', 'Puma', 89.99, 45.00);

INSERT INTO customers VALUES
    (1, 'Rajesh Kumar', 32, 'Male', 'Mumbai', '2024-01-15', 'Gold'),
    (2, 'Priya Sharma', 28, 'Female', 'Delhi', '2024-01-20', 'Silver'),
    (3, 'Amit Patel', 45, 'Male', 'Ahmedabad', '2024-02-01', 'Platinum'),
    (4, 'Neha Gupta', 35, 'Female', 'Bangalore', '2024-02-10', 'Gold'),
    (5, 'Vikram Singh', 29, 'Male', 'Jaipur', '2024-02-15', 'Silver'),
    (6, 'Anjali Reddy', 31, 'Female', 'Hyderabad', '2024-03-01', 'Bronze'),
    (7, 'Suresh Nair', 52, 'Male', 'Chennai', '2024-03-10', 'Platinum'),
    (8, 'Deepa Krishnan', 27, 'Female', 'Kochi', '2024-03-15', 'Silver'),
    (9, 'Rahul Verma', 41, 'Male', 'Lucknow', '2024-04-01', 'Gold'),
    (10, 'Pooja Desai', 33, 'Female', 'Pune', '2024-04-10', 'Bronze');

INSERT INTO orders VALUES
    (1, 1, '2024-04-01', 2199.97, 'Delivered'),
    (2, 2, '2024-04-01', 1099.98, 'Delivered'),
    (3, 3, '2024-04-02', 2799.98, 'Shipped'),
    (4, 4, '2024-04-02', 389.97, 'Delivered'),
    (5, 5, '2024-04-03', 179.98, 'Processing'),
    (6, 6, '2024-04-03', 599.97, 'Delivered'),
    (7, 7, '2024-04-04', 2499.98, 'Shipped'),
    (8, 8, '2024-04-04', 299.97, 'Delivered'),
    (9, 9, '2024-04-05', 1199.98, 'Processing'),
    (10, 10, '2024-04-05', 449.97, 'Delivered'),
    (11, 1, '2024-04-06', 899.99, 'Delivered'),
    (12, 3, '2024-04-06', 1599.98, 'Shipped'),
    (13, 5, '2024-04-07', 279.98, 'Delivered'),
    (14, 7, '2024-04-07', 329.98, 'Processing'),
    (15, 2, '2024-04-08', 1199.97, 'Delivered');

INSERT INTO order_details VALUES
    (1, 1, 1, 1, 999.99, 0),
    (2, 1, 3, 1, 1999.99, 0),
    (3, 1, 6, 1, 199.99, 0),
    (4, 2, 2, 1, 899.99, 0),
    (5, 2, 4, 1, 129.99, 0),
    (6, 2, 5, 1, 149.99, 0),
    (7, 3, 3, 1, 1999.99, 0),
    (8, 3, 1, 1, 999.99, 0),
    (9, 4, 7, 2, 79.99, 10),
    (10, 4, 8, 3, 39.99, 5),
    (11, 5, 4, 1, 129.99, 0),
    (12, 5, 10, 1, 89.99, 0),
    (13, 6, 6, 3, 199.99, 0),
    (14, 7, 3, 1, 1999.99, 50),
    (15, 7, 1, 1, 999.99, 50),
    (16, 8, 8, 2, 39.99, 0),
    (17, 8, 7, 1, 79.99, 0),
    (18, 9, 2, 1, 899.99, 100),
    (19, 9, 9, 1, 299.99, 0),
    (20, 10, 10, 3, 89.99, 0),
    (21, 10, 5, 1, 149.99, 0),
    (22, 11, 2, 1, 899.99, 0),
    (23, 12, 3, 1, 1999.99, 200),
    (24, 12, 6, 1, 199.99, 0),
    (25, 13, 4, 2, 129.99, 0),
    (26, 14, 7, 2, 79.99, 0),
    (27, 14, 10, 1, 89.99, 0),
    (28, 15, 1, 1, 999.99, 0),
    (29, 15, 6, 1, 199.99, 0);

-- REPORT 1: Sales Performance Dashboard with Multiple Metrics
WITH daily_sales AS (
    SELECT 
        o.order_date,
        COUNT(DISTINCT o.order_id) AS order_count,
        COUNT(DISTINCT o.customer_id) AS customer_count,
        SUM(od.quantity) AS items_sold,
        SUM(od.quantity * od.price * (1 - od.discount/100)) AS revenue,
        SUM((od.price - p.cost) * od.quantity) AS profit
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.order_date
),
sales_metrics AS (
    SELECT 
        *,
        LAG(revenue, 1) OVER (ORDER BY order_date) AS prev_day_revenue,
        LAG(revenue, 7) OVER (ORDER BY order_date) AS prev_week_revenue,
        AVG(revenue) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS revenue_moving_avg_3d,
        AVG(revenue) OVER (ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS revenue_moving_avg_7d,
        SUM(revenue) OVER (ORDER BY order_date) AS cumulative_revenue,
        SUM(profit) OVER (ORDER BY order_date) AS cumulative_profit,
        RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
    FROM daily_sales
)
SELECT 
    order_date,
    order_count,
    customer_count,
    items_sold,
    ROUND(revenue, 2) AS revenue,
    ROUND(profit, 2) AS profit,
    ROUND((profit / NULLIF(revenue, 0)) * 100, 2) AS profit_margin_percent,
    ROUND(revenue / NULLIF(order_count, 0), 2) AS avg_order_value,
    ROUND(revenue / NULLIF(customer_count, 0), 2) AS revenue_per_customer,
    ROUND(((revenue - prev_day_revenue) / NULLIF(prev_day_revenue, 0)) * 100, 2) AS daily_growth_percent,
    ROUND(((revenue - prev_week_revenue) / NULLIF(prev_week_revenue, 0)) * 100, 2) AS weekly_growth_percent,
    ROUND(revenue_moving_avg_3d, 2) AS moving_avg_3d,
    ROUND(revenue_moving_avg_7d, 2) AS moving_avg_7d,
    ROUND(cumulative_revenue, 2) AS cumulative_revenue,
    ROUND(cumulative_profit, 2) AS cumulative_profit
FROM sales_metrics
ORDER BY order_date;

-- REPORT 2: Product Performance Analysis with Rankings
WITH product_sales AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category,
        p.brand,
        p.price AS current_price,
        SUM(od.quantity) AS total_quantity_sold,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT o.customer_id) AS unique_customers,
        SUM(od.quantity * od.price * (1 - od.discount/100)) AS total_revenue,
        SUM((od.price - p.cost) * od.quantity) AS total_profit,
        AVG(od.discount) AS avg_discount_percent
    FROM products p
    LEFT JOIN order_details od ON p.product_id = od.product_id
    LEFT JOIN orders o ON od.order_id = o.order_id
    GROUP BY p.product_id, p.product_name, p.category, p.brand, p.price
),
ranked_products AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
        RANK() OVER (ORDER BY total_quantity_sold DESC) AS volume_rank,
        DENSE_RANK() OVER (ORDER BY total_profit DESC) AS profit_rank,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS category_rank,
        FIRST_VALUE(product_name) OVER (PARTITION BY category ORDER BY total_revenue DESC) AS top_product_in_category,
        LAST_VALUE(product_name) OVER (PARTITION BY category ORDER BY total_revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS bottom_product_in_category,
        SUM(total_revenue) OVER (PARTITION BY category) AS category_total_revenue,
        SUM(total_revenue) OVER () AS overall_total_revenue,
        RATIO_TO_REPORT(total_revenue) OVER () AS revenue_contribution_ratio
    FROM product_sales
)
SELECT 
    product_name,
    category,
    brand,
    total_quantity_sold,
    total_orders,
    unique_customers,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(total_profit, 2) AS total_profit,
    ROUND((total_profit / NULLIF(total_revenue, 0)) * 100, 2) AS profit_margin,
    ROUND(total_revenue / NULLIF(total_orders, 0), 2) AS revenue_per_order,
    revenue_rank,
    volume_rank,
    profit_rank,
    category_rank,
    top_product_in_category,
    ROUND((total_revenue / category_total_revenue) * 100, 2) AS category_share_percent,
    ROUND((total_revenue / overall_total_revenue) * 100, 2) AS overall_share_percent,
    ROUND(revenue_contribution_ratio * 100, 2) AS contribution_percent,
    CASE 
        WHEN revenue_rank <= 3 THEN 'Star Performer'
        WHEN revenue_rank <= 6 THEN 'Consistent Performer'
        WHEN revenue_rank <= 9 THEN 'Average Performer'
        ELSE 'Needs Review'
    END AS performance_tier
FROM ranked_products
ORDER BY revenue_rank;

-- REPORT 3: Customer Segmentation and Behavior Analysis
WITH customer_stats AS (
    SELECT 
        c.customer_id,
        c.name,
        c.age,
        c.gender,
        c.city,
        c.membership_level,
        c.signup_date,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT od.product_id) AS unique_products_bought,
        SUM(od.quantity) AS total_items_purchased,
        SUM(od.quantity * od.price * (1 - od.discount/100)) AS total_spent,
        AVG(od.quantity * od.price * (1 - od.discount/100)) AS avg_order_value,
        MAX(o.order_date) AS last_order_date,
        MIN(o.order_date) AS first_order_date,
        EXTRACT(DAY FROM CURRENT_DATE - MAX(o.order_date)) AS days_since_last_order
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_details od ON o.order_id = od.order_id
    GROUP BY c.customer_id, c.name, c.age, c.gender, c.city, c.membership_level, c.signup_date
    HAVING COUNT(DISTINCT o.order_id) > 0
),
customer_segments AS (
    SELECT 
        *,
        -- RFM Scoring (1-5 scale)
        CASE 
            WHEN days_since_last_order <= 7 THEN 5
            WHEN days_since_last_order <= 15 THEN 4
            WHEN days_since_last_order <= 30 THEN 3
            WHEN days_since_last_order <= 60 THEN 2
            ELSE 1
        END AS recency_score,
        
        CASE 
            WHEN total_orders >= 5 THEN 5
            WHEN total_orders >= 3 THEN 4
            WHEN total_orders >= 2 THEN 3
            WHEN total_orders >= 1 THEN 2
            ELSE 1
        END AS frequency_score,
        
        CASE 
            WHEN total_spent >= 5000 THEN 5
            WHEN total_spent >= 2000 THEN 4
            WHEN total_spent >= 1000 THEN 3
            WHEN total_spent >= 500 THEN 2
            ELSE 1
        END AS monetary_score,
        
        -- Customer Lifetime Value (CLV) segments
        PERCENT_RANK() OVER (ORDER BY total_spent) AS spending_percentile,
        NTILE(4) OVER (ORDER BY total_spent) AS spending_quartile
    FROM customer_stats
),
customer_classification AS (
    SELECT 
        *,
        (recency_score + frequency_score + monetary_score) AS rfm_total,
        CONCAT(recency_score, frequency_score, monetary_score) AS rfm_cell,
        
        CASE 
            WHEN recency_score = 5 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'VIP Customers'
            WHEN recency_score >= 4 AND frequency_score >= 3 AND monetary_score >= 3 THEN 'Loyal Customers'
            WHEN recency_score = 5 AND frequency_score <= 2 AND monetary_score <= 2 THEN 'New Customers'
            WHEN recency_score <= 2 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'At Risk VIP'
            WHEN recency_score <= 2 AND frequency_score >= 3 AND monetary_score >= 3 THEN 'At Risk'
            WHEN recency_score <= 2 AND frequency_score <= 2 AND monetary_score <= 2 THEN 'Lost Customers'
            WHEN recency_score >= 4 AND frequency_score <= 2 AND monetary_score <= 3 THEN 'Promising'
            ELSE 'Regular Customers'
        END AS customer_segment_name,
        
        CASE 
            WHEN spending_percentile >= 0.8 THEN 'High Value'
            WHEN spending_percentile >= 0.5 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS value_category
    FROM customer_segments
)
SELECT 
    name,
    age,
    gender,
    city,
    membership_level,
    total_orders,
    total_items_purchased,
    unique_products_bought,
    ROUND(total_spent, 2) AS total_spent,
    ROUND(avg_order_value, 2) AS avg_order_value,
    days_since_last_order,
    last_order_date,
    recency_score,
    frequency_score,
    monetary_score,
    rfm_total,
    rfm_cell,
    customer_segment_name,
    value_category,
    spending_quartile,
    
    -- Product preferences
    (SELECT product_name 
     FROM products p 
     JOIN order_details od ON p.product_id = od.product_id
     JOIN orders o ON od.order_id = o.order_id
     WHERE o.customer_id = customer_stats.customer_id
     GROUP BY p.product_name
     ORDER BY SUM(od.quantity) DESC 
     LIMIT 1) AS most_bought_product,
     
    ROUND(AVG(od.discount)::DECIMAL, 2) AS avg_discount_received
FROM customer_classification
LEFT JOIN order_details od ON customer_classification.customer_id = od.order_id
LEFT JOIN orders o ON od.order_id = o.order_id
GROUP BY name, age, gender, city, membership_level, total_orders, total_items_purchased, 
         unique_products_bought, total_spent, avg_order_value, days_since_last_order,
         last_order_date, recency_score, frequency_score, monetary_score, rfm_total,
         rfm_cell, customer_segment_name, value_category, spending_quartile,
         customer_classification.customer_id
ORDER BY total_spent DESC;

-- REPORT 4: Trend Analysis and Forecasting
WITH monthly_trends AS (
    SELECT 
        DATE_TRUNC('month', o.order_date) AS month,
        COUNT(DISTINCT o.order_id) AS orders,
        COUNT(DISTINCT o.customer_id) AS customers,
        SUM(od.quantity) AS units_sold,
        SUM(od.quantity * od.price * (1 - od.discount/100)) AS revenue,
        SUM((od.price - p.cost) * od.quantity) AS profit,
        
        -- Product mix
        SUM(CASE WHEN p.category = 'Electronics' THEN od.quantity ELSE 0 END) AS electronics_units,
        SUM(CASE WHEN p.category = 'Footwear' THEN od.quantity ELSE 0 END) AS footwear_units,
        SUM(CASE WHEN p.category = 'Clothing' THEN od.quantity ELSE 0 END) AS clothing_units
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY DATE_TRUNC('month', o.order_date)
),
trend_analysis AS (
    SELECT 
        month,
        orders,
        customers,
        units_sold,
        ROUND(revenue, 2) AS revenue,
        ROUND(profit, 2) AS profit,
        ROUND(revenue / NULLIF(orders, 0), 2) AS revenue_per_order,
        ROUND(profit / NULLIF(revenue, 0) * 100, 2) AS profit_margin,
        electronics_units,
        footwear_units,
        clothing_units,
        
        -- Growth rates
        ROUND(((revenue - LAG(revenue, 1) OVER (ORDER BY month)) / NULLIF(LAG(revenue, 1) OVER (ORDER BY month), 0)) * 100, 2) AS revenue_growth,
        ROUND(((customers - LAG(customers, 1) OVER (ORDER BY month)) / NULLIF(LAG(customers, 1) OVER (ORDER BY month), 0)) * 100, 2) AS customer_growth,
        
        -- Moving averages
        ROUND(AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 1 PRECEDING AND CURRENT ROW), 2) AS revenue_2ma,
        ROUND(AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS revenue_3ma,
        
        -- Year-over-Year comparison (simulated with previous period)
        LAG(revenue, 1) OVER (ORDER BY month) AS previous_period_revenue,
        
        -- Running totals
        SUM(revenue) OVER (ORDER BY month) AS cumulative_revenue_ytd,
        SUM(profit) OVER (ORDER BY month) AS cumulative_profit_ytd
    FROM monthly_trends
)
SELECT 
    TO_CHAR(month, 'YYYY-MM') AS month,
    orders,
    customers,
    units_sold,
    revenue,
    profit,
    profit_margin,
    revenue_per_order,
    revenue_growth,
    customer_growth,
    revenue_2ma,
    revenue_3ma,
    cumulative_revenue_ytd,
    cumulative_profit_ytd,
    
    -- Product mix percentages
    ROUND((electronics_units::DECIMAL / NULLIF(units_sold, 0)) * 100, 2) AS electronics_percent,
    ROUND((footwear_units::DECIMAL / NULLIF(units_sold, 0)) * 100, 2) AS footwear_percent,
    ROUND((clothing_units::DECIMAL / NULLIF(units_sold, 0)) * 100, 2) AS clothing_percent,
    
    -- Trend indicators
    CASE 
        WHEN revenue_growth > 10 THEN 'Strong Growth'
        WHEN revenue_growth > 0 THEN 'Moderate Growth'
        WHEN revenue_growth > -10 THEN 'Slight Decline'
        ELSE 'Significant Decline'
    END AS revenue_trend,
    
    CASE 
        WHEN profit_margin > 30 THEN 'Excellent'
        WHEN profit_margin > 20 THEN 'Good'
        WHEN profit_margin > 10 THEN 'Average'
        ELSE 'Poor'
    END AS margin_performance
FROM trend_analysis
ORDER BY month;

-- REPORT 5: Category Performance Matrix
WITH category_stats AS (
    SELECT 
        p.category,
        COUNT(DISTINCT p.product_id) AS total_products,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT o.customer_id) AS unique_customers,
        SUM(od.quantity) AS units_sold,
        SUM(od.quantity * od.price * (1 - od.discount/100)) AS revenue,
        SUM((od.price - p.cost) * od.quantity) AS profit,
        AVG(od.discount) AS avg_discount,
        
        -- Popular products in category
        MODE() WITHIN GROUP (ORDER BY p.brand) AS most_popular_brand
    FROM products p
    LEFT JOIN order_details od ON p.product_id = od.product_id
    LEFT JOIN orders o ON od.order_id = o.order_id
    GROUP BY p.category
),
category_matrix AS (
    SELECT 
        *,
        RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
        RANK() OVER (ORDER BY profit DESC) AS profit_rank,
        RANK() OVER (ORDER BY units_sold DESC) AS volume_rank,
        
        -- Market share calculations
        ROUND((revenue / SUM(revenue) OVER ()) * 100, 2) AS revenue_share,
        ROUND((profit / SUM(profit) OVER ()) * 100, 2) AS profit_share,
        
        -- Performance matrix positioning
        PERCENT_RANK() OVER (ORDER BY revenue) AS revenue_percentile,
        PERCENT_RANK() OVER (ORDER BY profit_margin) AS margin_percentile
    FROM (
        SELECT 
            category,
            total_products,
            total_orders,
            unique_customers,
            units_sold,
            ROUND(revenue, 2) AS revenue,
            ROUND(profit, 2) AS profit,
            ROUND((profit / NULLIF(revenue, 0)) * 100, 2) AS profit_margin,
            ROUND(revenue / NULLIF(unique_customers, 0), 2) AS revenue_per_customer,
            avg_discount,
            most_popular_brand
        FROM category_stats
    ) AS calc
)
SELECT 
    category,
    total_products,
    total_orders,
    unique_customers,
    units_sold,
    revenue,
    profit,
    profit_margin,
    revenue_per_customer,
    avg_discount,
    most_popular_brand,
    revenue_share || '%' AS revenue_share,
    profit_share || '%' AS profit_share,
    revenue_rank,
    profit_rank,
    volume_rank,
    
    -- Boston Consulting Group (BCG) Matrix classification
    CASE 
        WHEN revenue_percentile >= 0.7 AND margin_percentile >= 0.7 THEN 'Star'
        WHEN revenue_percentile >= 0.7 AND margin_percentile < 0.3 THEN 'Cash Cow'
        WHEN revenue_percentile < 0.3 AND margin_percentile >= 0.7 THEN 'Question Mark'
        WHEN revenue_percentile < 0.3 AND margin_percentile < 0.3 THEN 'Dog'
        ELSE 'Average Performer'
    END AS bcg_matrix_position,
    
    CASE 
        WHEN revenue_rank = 1 THEN 'Market Leader'
        WHEN revenue_rank <= 2 THEN 'Strong Contender'
        WHEN revenue_rank <= 3 THEN 'Growing Player'
        ELSE 'Niche Player'
    END AS market_position
FROM category_matrix
ORDER BY revenue DESC;

-- Display base tables
SELECT '=== PRODUCTS TABLE ===' AS table_header;
SELECT * FROM products;

SELECT '=== CUSTOMERS TABLE ===' AS table_header;
SELECT * FROM customers;

SELECT '=== ORDERS TABLE ===' AS table_header;
SELECT * FROM orders;

SELECT '=== ORDER_DETAILS TABLE ===' AS table_header;
SELECT * FROM order_details;
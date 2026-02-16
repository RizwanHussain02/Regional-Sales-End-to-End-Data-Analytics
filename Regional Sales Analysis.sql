/* =========================================================
   PROJECT: REGIONAL SALES ANALYSIS
   DATABASE: regional_sales_db
   TABLE: sales_data
   PURPOSE: Analytical Layer for Power BI
========================================================= */


/* =========================================================
   1. DATA VALIDATION
========================================================= */

-- Preview data
SELECT * FROM sales_data LIMIT 10;

-- Row count
SELECT COUNT(*) AS total_rows FROM sales_data;


/* =========================================================
   2. CORE BUSINESS KPIs
========================================================= */

-- Total Revenue
SELECT SUM(revenue) AS total_revenue
FROM sales_data;

-- Total Profit
SELECT SUM(profit) AS total_profit
FROM sales_data;

-- Overall Profit Margin %
SELECT 
    ROUND((SUM(profit) / SUM(revenue)) * 100, 2) AS overall_margin_pct
FROM sales_data;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM sales_data;

-- Average Revenue per Order
SELECT 
    ROUND(SUM(revenue) / COUNT(DISTINCT order_id), 2) AS avg_revenue_per_order
FROM sales_data;


/* =========================================================
   3. TIME SERIES ANALYSIS
========================================================= */

-- Monthly Revenue Trend
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(revenue) AS monthly_revenue,
    SUM(profit) AS monthly_profit
FROM sales_data
GROUP BY month
ORDER BY month;


/* =========================================================
   4. COMPANY PERFORMANCE
========================================================= */

-- Top 5 Companies by Revenue
SELECT 
    company_name,
    SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY company_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Top 5 Companies by Margin
SELECT 
    company_name,
    ROUND((SUM(profit) / SUM(revenue)) * 100, 2) AS margin_pct
FROM sales_data
GROUP BY company_name
ORDER BY margin_pct DESC
LIMIT 5;


/* =========================================================
   5. PRODUCT PERFORMANCE
========================================================= */

-- Revenue by Product
SELECT 
    product_name,
    SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY product_name
ORDER BY total_revenue DESC;

-- Margin by Product
SELECT 
    product_name,
    ROUND((SUM(profit) / SUM(revenue)) * 100, 2) AS margin_pct
FROM sales_data
GROUP BY product_name
ORDER BY margin_pct DESC;


/* =========================================================
   6. REGIONAL PERFORMANCE
========================================================= */

-- Revenue by Region
SELECT 
    region,
    SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY region
ORDER BY total_revenue DESC;

-- Margin by Region
SELECT 
    region,
    ROUND((SUM(profit) / SUM(revenue)) * 100, 2) AS margin_pct
FROM sales_data
GROUP BY region
ORDER BY margin_pct DESC;


/* =========================================================
   7. CHANNEL PERFORMANCE
========================================================= */

-- Revenue by Channel
SELECT 
    channel,
    SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY channel
ORDER BY total_revenue DESC;

-- Profit by Channel
SELECT 
    channel,
    SUM(profit) AS total_profit
FROM sales_data
GROUP BY channel
ORDER BY total_profit DESC;

-- Margin by Channel
SELECT 
    channel,
    ROUND((SUM(profit) / SUM(revenue)) * 100, 2) AS margin_pct
FROM sales_data
GROUP BY channel
ORDER BY margin_pct DESC;


/* =========================================================
   8. STATE ANALYSIS
========================================================= */

-- Top 5 States by Revenue
SELECT 
    state,
    SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 5;


/* =========================================================
   9. ADVANCED SQL – WINDOW FUNCTION
========================================================= */

-- Rank companies by revenue
SELECT 
    company_name,
    SUM(revenue) AS total_revenue,
    RANK() OVER (ORDER BY SUM(revenue) DESC) AS revenue_rank
FROM sales_data
GROUP BY company_name;

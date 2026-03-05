CREATE DATABASE ecommerce_project;
USE ecommerce_project;

-- Table Structure
CREATE TABLE ecommerce_data (
    customer_id INT,
    purchase_date DATETIME,
    product_category VARCHAR(100),
    product_price DECIMAL(10,2),
    quantity INT,
    total_purchase_amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    customer_age INT,
    returns DECIMAL(5,2),
    customer_name VARCHAR(100),
    age INT,
    gender VARCHAR(20),
    churn INT
);

-- Importing CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ecommerce_customer_data_custom_ratios.csv'
INTO TABLE ecommerce_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id,
 purchase_date,
 product_category,
 product_price,
 quantity,
 total_purchase_amount,
 payment_method,
 customer_age,
 @returns,
 customer_name,
 age,
 gender,
 churn)
SET returns = NULLIF(@returns, '');

SELECT COUNT(*) FROM ecommerce_data;

-- Check NULL Values
SELECT 
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(purchase_date IS NULL) AS null_purchase_date,
    SUM(product_price IS NULL) AS null_product_price,
    SUM(quantity IS NULL) AS null_quantity,
    SUM(total_purchase_amount IS NULL) AS null_total_purchase_amount,
    SUM(returns IS NULL) AS null_returns,
    SUM(age IS NULL) AS null_age,
    SUM(churn IS NULL) AS null_churn
FROM ecommerce_data;

-- Check Duplicate Records
SELECT customer_id, purchase_date, COUNT(*)
FROM ecommerce_data
GROUP BY customer_id, purchase_date
HAVING COUNT(*) > 1;

-- Validate Revenue Calculation
SELECT COUNT(*) AS mismatch_count
FROM ecommerce_data
WHERE total_purchase_amount <> product_price * quantity;

-- Check Age Column Conflict
SELECT COUNT(*) AS age_mismatch
FROM ecommerce_data
WHERE customer_age <> age;

SELECT product_price,
       quantity,
       total_purchase_amount,
       product_price * quantity AS expected_amount
FROM ecommerce_data
LIMIT 10;

ALTER TABLE ecommerce_data
DROP COLUMN customer_age;

DESCRIBE ecommerce_data;

-- Total Revenue
SELECT 
    ROUND(SUM(total_purchase_amount),2) AS total_revenue
FROM ecommerce_data;

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM ecommerce_data;

-- Average Order Value (AOV)
SELECT 
    ROUND(SUM(total_purchase_amount)/COUNT(*),2) AS avg_order_value
FROM ecommerce_data;

-- Revenue by Year
SELECT 
    YEAR(purchase_date) AS purchase_year,
    ROUND(SUM(total_purchase_amount),2) AS yearly_revenue
FROM ecommerce_data
GROUP BY YEAR(purchase_date)
ORDER BY purchase_year;

-- To Check last year is half or full
SELECT 
    MIN(purchase_date) AS start_date,
    MAX(purchase_date) AS end_date
FROM ecommerce_data;

-- Revenue Till September (Each Year)
SELECT 
    YEAR(purchase_date) AS purchase_year,
    ROUND(SUM(total_purchase_amount),2) AS revenue_till_sep
FROM ecommerce_data
WHERE MONTH(purchase_date) <= 9
GROUP BY YEAR(purchase_date)
ORDER BY purchase_year;

-- Orders Till September
SELECT 
    YEAR(purchase_date) AS purchase_year,
    COUNT(*) AS orders_till_sep
FROM ecommerce_data
WHERE MONTH(purchase_date) <= 9
GROUP BY YEAR(purchase_date)
ORDER BY purchase_year;

-- AOV Till September
SELECT 
    YEAR(purchase_date) AS purchase_year,
    ROUND(SUM(total_purchase_amount)/COUNT(*),2) AS aov_till_sep
FROM ecommerce_data
WHERE MONTH(purchase_date) <= 9
GROUP BY YEAR(purchase_date)
ORDER BY purchase_year;

-- Churn Rate by Year (Till September)
SELECT 
    YEAR(purchase_date) AS purchase_year,
    COUNT(CASE WHEN churn = 1 THEN 1 END) AS churned_customers,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(CASE WHEN churn = 1 THEN 1 END) * 100.0 / COUNT(*), 
        2
    ) AS churn_rate_percentage
FROM ecommerce_data
WHERE MONTH(purchase_date) <= 9
GROUP BY YEAR(purchase_date)
ORDER BY purchase_year;

SELECT 
    YEAR(purchase_date) AS purchase_year,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM ecommerce_data
WHERE MONTH(purchase_date) <= 9
GROUP BY YEAR(purchase_date)
ORDER BY purchase_year;

-- Orders by Gender (Jan–Sep 2023)
SELECT 
    gender,
    COUNT(*) AS total_orders
FROM ecommerce_data
WHERE YEAR(purchase_date) = 2023
AND MONTH(purchase_date) <= 9
GROUP BY gender;

SELECT 
    gender,
    COUNT(*) AS total_orders
FROM ecommerce_data
WHERE YEAR(purchase_date) = 2022
AND MONTH(purchase_date) <= 9
GROUP BY gender;

SELECT 
    CASE 
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_orders
FROM ecommerce_data
WHERE YEAR(purchase_date) = 2022
AND MONTH(purchase_date) <= 9
GROUP BY age_group;

SELECT 
    CASE 
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_orders
FROM ecommerce_data
WHERE YEAR(purchase_date) = 2023
AND MONTH(purchase_date) <= 9
GROUP BY age_group;

SELECT 
    product_category,
    COUNT(*) AS total_orders
FROM ecommerce_data
WHERE YEAR(purchase_date) = 2022
AND MONTH(purchase_date) <= 9
GROUP BY product_category
ORDER BY total_orders DESC;

SELECT 
    product_category,
    COUNT(*) AS total_orders
FROM ecommerce_data
WHERE YEAR(purchase_date) = 2023
AND MONTH(purchase_date) <= 9
GROUP BY product_category
ORDER BY total_orders DESC;

SELECT 
    returns,
    COUNT(*) AS total_count
FROM ecommerce_data
GROUP BY returns;

SELECT 
    ROUND(
        SUM(CASE WHEN returns = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS overall_return_rate_percentage
FROM ecommerce_data;

SELECT 
    YEAR(purchase_date) AS purchase_year,
    ROUND(
        SUM(CASE WHEN returns = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS return_rate_percentage
FROM ecommerce_data
GROUP BY YEAR(purchase_date)
ORDER BY purchase_year;

SELECT 
    product_category,
    ROUND(
        SUM(CASE WHEN returns = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS return_rate_percentage
FROM ecommerce_data
GROUP BY product_category
ORDER BY return_rate_percentage DESC;

SELECT 
    returns,
    ROUND(
        COUNT(CASE WHEN churn = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM ecommerce_data
GROUP BY returns;
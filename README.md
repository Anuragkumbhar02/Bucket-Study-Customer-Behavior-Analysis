# Bucket-Study-Customer-Behavior-Analysis

## Project Overview

This project analyzes customer purchasing behavior for an e-commerce business to uncover insights related to revenue trends, customer churn, return patterns, and customer segmentation.

The goal is to help businesses understand **how customers behave, which segments generate the most revenue, and how to reduce churn while improving retention strategies.**

---

## Business Problem

E-commerce businesses often struggle to understand customer purchasing patterns, high return rates, and customer churn. Without proper analysis, companies may lose valuable customers and reduce profitability.

This project aims to analyze customer data to identify:

* Revenue trends
* Customer purchasing behavior
* High-value customers
* Churn patterns
* Return patterns

---

## Project Objectives

* Analyze revenue and order trends over time
* Identify high-value customer segments
* Understand customer churn behavior
* Analyze return patterns across categories
* Provide business recommendations to improve customer retention

---

## Dataset Information

The dataset contains **250,000 e-commerce transactions** with **50,000 unique customers**.

### Key Features

* `customer_id`
* `purchase_date`
* `product_category`
* `product_price`
* `quantity`
* `total_purchase_amount`
* `payment_method`
* `returns`
* `age`
* `gender`
* `churn`

---

## Tools & Technologies Used

| Tool                   | Purpose                                  |
| ---------------------- | ---------------------------------------- |
| Python (Pandas, NumPy) | Data cleaning and analysis               |
| Matplotlib & Seaborn   | Exploratory data analysis                |
| SQL (MySQL)            | Data querying and aggregation            |
| Excel                  | Quick data validation and pivot analysis |
| Power BI               | Interactive dashboard and visualization  |
| Jupyter Notebook       | Reproducible analysis workflow           |

---

## Project Workflow

### 1. Data Cleaning

* Checked for missing values
* Handled null values in `returns`
* Standardized column names
* Converted purchase date to datetime
* Verified total purchase amount calculations

### 2. Exploratory Data Analysis (Python)

Performed analysis to understand:

* Revenue trends
* Age group purchasing behavior
* Product category performance
* Churn patterns
* Return behavior

### 3. SQL Analysis

Used SQL for business metrics:

* Total revenue
* Total orders
* Average order value
* Return rate
* Churn rate
* Revenue by year and category

### 4. Customer Segmentation (RFM Analysis)

Customers were segmented based on:

* **Recency** – How recently a customer purchased
* **Frequency** – How often they purchase
* **Monetary** – How much they spend

Customer segments identified:

* Champions
* Loyal Customers
* Potential Loyalists
* At Risk
* Lost Customers

### 5. Dashboard Development

Built an **interactive Power BI dashboard** to visualize key business metrics.

---

## Dashboard KPIs

* **Total Revenue:** 681M
* **Total Orders:** 250K
* **Unique Customers:** 50K
* **Average Order Value:** 2.73K
* **Return Rate:** ~50%
* **Churn Rate:** ~20%

---

## Key Insights

* Customers aged **46-60 generate the highest revenue**
* **18-25 age group shows the highest churn rate**
* **Champions customer segment contributes the highest revenue**
* **Potential Loyalists represent the largest customer segment**
* **Books and Clothing are the top performing categories**

---

## Business Recommendations

* Implement **loyalty programs** to retain high-value customers
* Offer **targeted promotions** to reduce churn in younger customers
* Improve product descriptions to reduce **return rates**
* Provide personalized offers for **At-Risk customers**

---

## Dashboard Preview

![Dashboard Preview](https://github.com/Anuragkumbhar02/Walmart-Dashboard/blob/main/image.png)

---

## Project Structure

Customer-Behavior-Analysis
│
├── Dataset
├── Python Analysis (EDA & RFM)
├── SQL Queries
├── Power BI Dashboard
└── README.md

---

## Author

**Anurag Kumbhar**

Aspiring Data Analyst passionate about data-driven decision making.

# 🔹 Project 2: E-Commerce Sales & Customer Behavior Analysis

## 📌 Introduction

This project analyzes e-commerce data to understand sales performance, customer behavior, payment trends, and delivery efficiency to improve business decision-making.

---

## 📂 Data Sources

The dataset includes:

* Orders data
* Customer details
* Product information
* Payment methods
* Delivery and review data

---

## 📊 Project Overview

* Imported and structured raw data using SQL
* Created master dataset using joins
* Performed analysis on sales, payments, and delivery
* Built interactive dashboards in Power BI

---

## 🛠 Tools & Technologies

* Excel, PostgreSQL, Power BI

---

## 📌 SQL: Master Table Creation

```sql
SELECT 
    o.order_id,
    o.customer_id,
    c.customer_city,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    oi.product_id,
    oi.price,
    oi.freight_value,
    p.product_category_name,
    py.payment_type,
    py.payment_value,
    r.review_score
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN order_payments py ON o.order_id = py.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id;
```

---

## 📌 SQL: Payment Analysis

```sql
SELECT payment_type, COUNT(*) 
FROM master_table
GROUP BY payment_type
ORDER BY COUNT(*) DESC;
```

---

## 📌 SQL: Delivery Performance

```sql
SELECT 
COUNT(*) FILTER (WHERE order_delivered_customer_date > order_estimated_delivery_date) AS late_orders,
COUNT(*) AS total_orders
FROM master_table;
```

---

## 📌 SQL: Category Analysis

```sql
SELECT product_category_name, SUM(price) AS revenue
FROM master_table
GROUP BY product_category_name
ORDER BY revenue DESC;
```

---

## 📊 Key Insights

* Credit card contributed majority (~75%) of transactions
* Identified ~40%+ late deliveries affecting customer experience
* Top product categories generated highest revenue
* Customer ratings provided insights into satisfaction

---

## 🚀 Conclusion

This project highlights the use of SQL and Power BI to generate actionable insights from e-commerce data.

---

# 📂 Project Structure

```
📁 Data-Analytics-Projects
 ├── Retail-Project/
 ├── E-Commerce-Project/
 └── README.md
```

---

# 🔥 Future Improvements

* Add machine learning models (churn prediction, forecasting)
* Improve dashboard interactivity
* Expand customer segmentation

---

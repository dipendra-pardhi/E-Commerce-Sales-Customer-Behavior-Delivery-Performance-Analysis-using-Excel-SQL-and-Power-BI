CREATE DATABASE ecommerce_project;


	CREATE TABLE product_category_translation (
    product_category_name TEXT,
    product_category_name_english TEXT
);

		COPY product_category_translation
		FROM 'C:\Users\Dipendra\Desktop\product_category_name_translation 1.csv'
		DELIMITER ','
		CSV HEADER;

	


SELECT * FROM product_category_translation LIMIT 10;


	CREATE TABLE geolocation (
	    geolocation_zip_code_prefix INT,
	    geolocation_lat NUMERIC,
	    geolocation_lng NUMERIC,
	    geolocation_city TEXT,
	    geolocation_state TEXT
);

		COPY geolocation
		FROM 'C:\Users\Dipendra\Desktop\olist_geolocation_dataset 2.csv'
		DELIMITER ','
		CSV HEADER;

SELECT COUNT(*) FROM geolocation;    


	CREATE TABLE customers (
	    customer_id TEXT,
	    customer_unique_id TEXT,
	    customer_zip_code_prefix INT,
	    customer_city TEXT,
	    customer_state TEXT
);

		COPY customers
		FROM 'C:\Users\Dipendra\Desktop\olist_customers_dataset 3.csv'
		DELIMITER ','
		CSV HEADER;

SELECT COUNT(*) FROM customers;


	CREATE TABLE sellers (
	    seller_id TEXT,
	    seller_zip_code_prefix INT,
	    seller_city TEXT,
	    seller_state TEXT
);

		COPY sellers
		FROM 'C:\Users\Dipendra\Desktop\olist_sellers_dataset 4.csv'
		DELIMITER ','
		CSV HEADER;

SELECT COUNT(*) FROM sellers;


	CREATE TABLE products (
	    product_id TEXT,
	    product_category_name TEXT,
	    product_name_length INT,
	    product_description_length INT,
	    product_photos_qty INT,
	    product_weight_g INT,
	    product_length_cm INT,
	    product_height_cm INT,
	    product_width_cm INT
	);

				COPY products
		FROM 'C:\Users\Dipendra\OneDrive\New folder\MY WALLPAPERS\Downloads\Power BI Practice Data Files\EXCEL, SQL, POWER BI, Project Files\olist_products_dataset 5.csv'
		DELIMITER ','
		CSV HEADER;
		
SELECT COUNT(*) FROM products;


	DROP TABLE IF EXISTS orders;

	CREATE TABLE orders (
	    order_id TEXT,
	    customer_id TEXT,
	    order_status TEXT,
	    order_purchase_timestamp TEXT,
	    order_approved_at TEXT,
	    order_delivered_carrier_date TEXT,
	    order_delivered_customer_date TEXT,
	    order_estimated_delivery_date TEXT
	);

		COPY orders
		FROM 'C:\Users\Dipendra\Desktop\olist_orders_dataset.csv'
		DELIMITER ','
		CSV HEADER;

SELECT COUNT(*) FROM orders;


	CREATE TABLE order_items (
	    order_id TEXT,
	    order_item_id INT,
	    product_id TEXT,
	    seller_id TEXT,
	    shipping_limit_date TEXT,
	    price NUMERIC,
	    freight_value NUMERIC
	);

	COPY order_items
	FROM 'C:\Users\Dipendra\Desktop\olist_order_items_dataset.csv'
	DELIMITER ','
	CSV HEADER;

SELECT COUNT(*) FROM order_items;

CREATE TABLE order_payments (
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value NUMERIC
);


COPY order_payments
FROM 'C:\Users\Dipendra\OneDrive\New folder\MY WALLPAPERS\Downloads\Power BI Practice Data Files\EXCEL, SQL, POWER BI, Project Files\olist_order_payments_dataset 8.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM order_payments;


CREATE TABLE order_reviews (
    review_id TEXT,
    order_id TEXT,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TEXT,
    review_answer_timestamp TEXT
);

COPY order_reviews
FROM 'C:\Users\Dipendra\OneDrive\New folder\MY WALLPAPERS\Downloads\Power BI Practice Data Files\EXCEL, SQL, POWER BI, Project Files\olist_order_reviews_dataset 9.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM order_reviews;


CREATE VIEW master_table AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_status,
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
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN order_payments py ON o.order_id = py.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id;


SELECT * FROM master_table LIMIT 10;


SELECT SUM(price + freight_value) AS total_revenue 
FROM master_table;

SELECT COUNT(DISTINCT order_id) FROM master_table;

SELECT AVG(review_score) FROM master_table;

SELECT payment_type, COUNT(*) 
FROM master_table
GROUP BY payment_type
ORDER BY COUNT(*) DESC;

SELECT product_category_name, SUM(price) AS revenue
FROM master_table
GROUP BY product_category_name
ORDER BY revenue DESC;

SELECT 
COUNT(*) FILTER (WHERE order_delivered_customer_date > order_estimated_delivery_date) AS late_orders,
COUNT(*) AS total_orders
FROM master_table;


DROP VIEW master_table;

CREATE VIEW master_table AS
SELECT 
    o.order_id,
    o.customer_id,
    c.customer_city,   -- 🔥 NEW ADD
    o.order_status,
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
JOIN customers c ON o.customer_id = c.customer_id   -- 🔥 JOIN ADDED
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN order_payments py ON o.order_id = py.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id;


DROP VIEW master_table;

CREATE VIEW master_table AS
SELECT 
    o.order_id,
    o.customer_id,
    c.customer_city,
    o.order_status,
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

SELECT * FROM master_table LIMIT 10;
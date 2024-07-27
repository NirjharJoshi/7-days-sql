-- 1. Create a database named "ecomSalesdata"
CREATE DATABASE IF NOT EXISTS ecomSalesdata;

SHOW DATABASES;

USE ecomSalesdata;

-- 2. Create a table inside the database named "ecomSalesdata"
-- Command to generate SQL File: csvsql --dialect mysql --snifflimit 10000 Sales_Dataset.csv > Result.sql
CREATE TABLE `Sales` (
	order_id VARCHAR(15) NOT NULL, 
	order_date DATE NOT NULL, 
	ship_date DATE NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 5) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	year DECIMAL(38, 0) NOT NULL
);

SHOW TABLES;

DESC Sales;

-- 3. Load the data available in Sales_Dataset.csv file to the Sales_Dataset table
-- Famous error: MySQL is running at secure-file-private error
-- secure-file-priv="C:/ProgramData/MySQL/MySQL Server 8.0/Uploads"
LOAD DATA INFILE 'C:/PersonalData/courses/7-days-sql/07-analyzing-e-commerce-trends-with-sql/Session Notes/Sales_Dataset.csv'
INTO TABLE Sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM Sales;

-- Identify the top 3 states with the highest shipping costs
-- state	highest_sum_shipping_cost
SELECT state, SUM(shipping_cost) AS sum_shipping_cost
FROM Sales
GROUP BY state
ORDER BY sum_shipping_cost DESC
LIMIT 3;

-- Common Table Expressions - Complexity of any given query + Resuability of the query
WITH states as (
	SELECT state, SUM(shipping_cost) AS sum_shipping_cost
	FROM Sales
	GROUP BY state
	ORDER BY sum_shipping_cost DESC
	LIMIT 3
)SELECT * FROM states;

-- Usually, whenver you feel a lot of subqueries or joins are there in your sql queries, go for CTE

-- Find the total sales for each year
-- year		total_sales
SELECT * FROM Sales;

SELECT s.year, SUM(sales) as total_sales FROM Sales AS s
GROUP BY s.year;

-- Data Analysis for an e-commerce company:

-- 1. List the top 5 products by sales amount.
SELECT * FROM Sales;

SELECT product_name, SUM(sales) AS total_sales FROM Sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

-- 2. Calculate the average profit margin per category.
SELECT * FROM Sales;

SELECT category, AVG(profit) AS avg_profit_margin FROM Sales
GROUP BY category;

SELECT category, AVG(profit * (100 - discount) / 100) AS avg_profit_margin FROM Sales
GROUP BY category;

-- 3. Find the number of orders placed per segment for the year 2012.
SELECT * FROM Sales;

SELECT segment, COUNT(order_id) AS order_placed FROM Sales
WHERE year = 2012
GROUP BY segment;

-- 4. Identify the top 3 states with the highest shipping costs.
SELECT * FROM Sales;

SELECT state, SUM(shipping_cost) AS total_shipping_cost FROM Sales
GROUP BY state
ORDER BY total_shipping_cost DESC
LIMIT 3;

-- 5. Calculate the total sales and profit for each market in the year 2012.
SELECT * FROM Sales;

SELECT market, SUM(sales) AS total_sales_2012, SUM(profit) AS total_profit_2012 FROM Sales
WHERE year = 2012
GROUP BY market;

-- 6. Determine the percentage of orders that had a discount applied.
SELECT * FROM Sales;

SELECT (COUNT(CASE WHEN discount > 0 THEN 1 END) * 100 ) / COUNT(order_id) AS percent_discounted_orders FROM Sales;

-- 7. Find the average shipping cost per order priority.
SELECT * FROM Sales;

SELECT order_priority, AVG(shipping_cost) AS avg_shipping_cost FROM Sales
GROUP BY order_priority;

-- 8. List the products with a profit margin greater than 20%.
SELECT * FROM Sales;

SELECT product_name, AVG(profit * (100 - discount) / 100) AS profit_margin FROM Sales
GROUP BY product_name
HAVING profit_margin > 20;

-- 9. Calculate the total quantity sold for each sub-category.
SELECT * FROM Sales;

SELECT sub_category, SUM(quantity) AS total_qt_sold FROM Sales
GROUP BY sub_category;

-- 10. Calculate the total sales and profit for each year, using a CTE.
SELECT * FROM Sales;

WITH tbl AS	(
	SELECT year, SUM(sales) AS total_sales, SUM(profit) AS total_profit FROM Sales
	GROUP BY year
) 
SELECT * FROM tbl;

-- 11. List the products with a profit margin greater than 20%, using a CTE.
SELECT * FROM Sales;

WITH tbl AS (
	SELECT product_name, AVG(profit * (100 - discount) / 100) AS avg_profit FROM Sales
	GROUP BY product_name
) 
SELECT * FROM tbl
WHERE avg_profit > 20;
create database pizza_DB;

-- import csv file of data

SELECT * FROM pizza_sales;

-- Total Revenue:
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;

-- . Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;


-- DAILY TREND
SELECT DAYNAME(order_date_fixed) as order_day, COUNT(DISTINCT order_id) as total_order
FROM pizza_sales
GROUP BY DAYNAME(order_date_fixed);

-- HOURLY TREND
SELECT HOUR(order_time) as order_hours , COUNT(DISTINCT order_id) as total_order
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

-- % of Sales by Pizza Category
SELECT pizza_category,
 CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- % of Sales by Pizza Size in january
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales where month(order_date_fixed)=1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
where month(order_date_fixed)=1
GROUP BY pizza_size
ORDER BY pizza_size;


-- total Pizzas Sold by Pizza Category
SELECT pizza_category,sum(quantity) as total_quantity_sold
FROM pizza_sales
GROUP BY pizza_category;

-- Top 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- Bottom 5 Best Sellers by Total Pizzas Sold in january
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
where month(order_date_fixed)=1
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold asc
LIMIT 5;


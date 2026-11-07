/*
PROJECT: Restaurant & Food Delivery Business Performance Analysis
DATABASE: food_delivery_analysis
DBMS: MySQL

DESCRIPTION
This script contains the data-cleaning workflow, data-quality checks,
and business analysis queries for the food delivery dataset.

EXPECTED TABLES
1. food_orders       - raw imported CSV data
2. food_orders_clean - cleaned analysis table

IMPORTANT
- The raw CSV should be imported into a table named food_orders first.
- The cleaning setup below has already been completed in this project.
- Do not rerun the CREATE / ALTER / INSERT cleaning statements on an
  existing populated clean table unless you intentionally rebuild it.
- cost_of_the_order is treated as recorded order value/revenue, NOT profit.
- Ratings marked 'Not given' are converted to NULL. AVG(rating) ignores NULL.
*/

USE food_delivery_analysis;


/* =========================================================
   SECTION 1: DATA CLEANING SETUP (ALREADY COMPLETED)
   Run these statements only when building the clean table
   for the first time. They are commented to prevent accidental
   duplicate inserts or overwriting existing work.
   ========================================================= */

/*
-- Create a new table with the same structure as the raw table.
CREATE TABLE food_orders_clean LIKE food_orders;

-- Allow the rating column to store numeric ratings and NULL values.
ALTER TABLE food_orders_clean
MODIFY rating DECIMAL(2,1) NULL;

-- Copy records while converting 'Not given' ratings to NULL.
INSERT INTO food_orders_clean
(
    order_id,
    customer_id,
    restaurant_name,
    cuisine_type,
    cost_of_the_order,
    day_of_the_week,
    rating,
    food_preparation_time,
    delivery_time
)
SELECT
    order_id,
    customer_id,
    restaurant_name,
    cuisine_type,
    cost_of_the_order,
    day_of_the_week,
    CAST(NULLIF(rating, 'Not given') AS DECIMAL(2,1)),
    food_preparation_time,
    delivery_time
FROM food_orders;
*/


/* =========================================================
   SECTION 2: DATA QUALITY CHECKS
   ========================================================= */

-- 2.1 Check total number of records.
SELECT COUNT(*) AS total_records
FROM food_orders_clean;

-- 2.2 Check for duplicate order IDs.
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM food_orders_clean
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 2.3 Check missing values in important columns.
-- NULL ratings are expected because some customers did not submit a rating.
SELECT
    SUM(customer_id IS NULL) AS missing_customer,
    SUM(restaurant_name IS NULL) AS missing_restaurant,
    SUM(cuisine_type IS NULL) AS missing_cuisine,
    SUM(cost_of_the_order IS NULL) AS missing_cost,
    SUM(day_of_the_week IS NULL) AS missing_day,
    SUM(food_preparation_time IS NULL) AS missing_prep_time,
    SUM(delivery_time IS NULL) AS missing_delivery_time,
    SUM(rating IS NULL) AS missing_rating
FROM food_orders_clean;

-- 2.4 Check for invalid or non-positive order costs.
SELECT *
FROM food_orders_clean
WHERE cost_of_the_order <= 0;

-- 2.5 Check for invalid or non-positive preparation/delivery times.
SELECT *
FROM food_orders_clean
WHERE food_preparation_time <= 0
   OR delivery_time <= 0;


/* =========================================================
   SECTION 3: OVERALL BUSINESS PERFORMANCE
   Business question: What is the overall performance?
   ========================================================= */

SELECT
    COUNT(*) AS total_orders,
    SUM(cost_of_the_order) AS total_revenue,
    AVG(cost_of_the_order) AS average_order_value,
    AVG(rating) AS average_rating,
    AVG(food_preparation_time) AS avg_preparation_time,
    AVG(delivery_time) AS avg_delivery_time
FROM food_orders_clean;


/* =========================================================
   SECTION 4: RESTAURANT ANALYSIS
   ========================================================= */

-- 4.1 Top 10 restaurants by total recorded order value.
SELECT
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(cost_of_the_order) AS total_revenue,
    AVG(cost_of_the_order) AS avg_order_value
FROM food_orders_clean
GROUP BY restaurant_name
ORDER BY total_revenue DESC
LIMIT 10;

-- 4.2 Top 10 restaurants by order volume.
SELECT
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(cost_of_the_order) AS total_revenue
FROM food_orders_clean
GROUP BY restaurant_name
ORDER BY total_orders DESC
LIMIT 10;

-- 4.3 Top 10 restaurants with the highest average delivery time.
-- Only restaurants with at least 10 orders are included.
SELECT
    restaurant_name,
    COUNT(order_id) AS total_orders,
    AVG(delivery_time) AS avg_delivery_time
FROM food_orders_clean
GROUP BY restaurant_name
HAVING COUNT(order_id) >= 10
ORDER BY avg_delivery_time DESC
LIMIT 10;

-- 4.4 Top 10 restaurants with the lowest average delivery time.
-- Only restaurants with at least 10 orders are included.
SELECT
    restaurant_name,
    COUNT(order_id) AS total_orders,
    AVG(delivery_time) AS avg_delivery_time
FROM food_orders_clean
GROUP BY restaurant_name
HAVING COUNT(order_id) >= 10
ORDER BY avg_delivery_time ASC
LIMIT 10;

-- 4.5 Top-rated restaurants.
-- Only restaurants with at least 10 submitted ratings are included.
SELECT
    restaurant_name,
    COUNT(rating) AS total_ratings,
    AVG(rating) AS average_rating
FROM food_orders_clean
GROUP BY restaurant_name
HAVING COUNT(rating) >= 10
ORDER BY average_rating DESC
LIMIT 10;

-- 4.6 Restaurants with the highest average food preparation time.
-- Only restaurants with at least 10 orders are included.
SELECT
    restaurant_name,
    COUNT(order_id) AS total_orders,
    AVG(food_preparation_time) AS avg_preparation_time
FROM food_orders_clean
GROUP BY restaurant_name
HAVING COUNT(order_id) >= 10
ORDER BY avg_preparation_time DESC
LIMIT 10;


/* =========================================================
   SECTION 5: CUISINE ANALYSIS
   ========================================================= */

-- 5.1 Cuisine performance by total recorded order value.
SELECT
    cuisine_type,
    COUNT(order_id) AS total_orders,
    SUM(cost_of_the_order) AS total_revenue,
    AVG(cost_of_the_order) AS avg_order_value
FROM food_orders_clean
GROUP BY cuisine_type
ORDER BY total_revenue DESC;

-- 5.2 Cuisine popularity and average customer rating.
SELECT
    cuisine_type,
    COUNT(order_id) AS total_orders,
    AVG(rating) AS average_rating
FROM food_orders_clean
GROUP BY cuisine_type
ORDER BY total_orders DESC;


/* =========================================================
   SECTION 6: CUSTOMER ANALYSIS
   ========================================================= */

-- 6.1 Top 10 customers by order frequency.
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(cost_of_the_order) AS total_spent,
    AVG(cost_of_the_order) AS avg_order_value
FROM food_orders_clean
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

-- 6.2 Top 10 customers by total spending.
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(cost_of_the_order) AS total_spent
FROM food_orders_clean
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;


/* =========================================================
   SECTION 7: WEEKDAY VS WEEKEND ANALYSIS
   ========================================================= */

-- 7.1 Compare order volume, recorded order value, and average order value.
SELECT
    day_of_the_week,
    COUNT(order_id) AS total_orders,
    SUM(cost_of_the_order) AS total_revenue,
    AVG(cost_of_the_order) AS avg_order_value
FROM food_orders_clean
GROUP BY day_of_the_week
ORDER BY total_orders DESC;

-- 7.2 Compare preparation and delivery times by day type.
SELECT
    day_of_the_week,
    AVG(food_preparation_time) AS avg_preparation_time,
    AVG(delivery_time) AS avg_delivery_time,
    MAX(delivery_time) AS max_delivery_time
FROM food_orders_clean
GROUP BY day_of_the_week;


/* =========================================================
   END OF ANALYSIS
   ========================================================= */

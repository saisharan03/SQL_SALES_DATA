--Analyze Sales Performance over time.
-- It gives overview insights that helps with strategic decision-making
/*
Change Over Time Analysis
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.
SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
*/
SELECT YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) AS total_quantity
FROM "gold.fact_sales"
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY YEAR(order_date),MONTH(order_date)

/* The DATE_TRUNC function in SQL is used to truncate a date or timestamp to a specific part, 
such as the year, month, day, hour, etc. It removes the more granular parts of the date or timestamp, 
leaving only the specified level of precision. */

SELECT 
DATETRUNC(month,order_date) AS order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) AS total_quantity
FROM "gold.fact_sales"
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month,order_date)
ORDER BY DATETRUNC(month,order_date)

--FORMAT

SELECT 
FORMAT(order_date, 'yyy-MMM') AS order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) AS total_quantity
FROM "gold.fact_sales"
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyy-MMM')
ORDER BY FORMAT(order_date, 'yyy-MMM')


/*
Group customers into three segments based on their spending behavior:
1.VIP: at least 12 months of history and spending > 5000$
2.REGULAR: at least 12 months of history and spending < = 5000$
3.New: lifespan less than 12 months.

And find the total number of customers by each group
*/
WITH customer_spending AS (
SELECT 
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF(month,MIN(order_date), MAX(order_date)) AS lifespan

FROM "gold.fact_sales" f
LEFT JOIN "gold.dim_customers" c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key)

SELECT 
CASE WHEN lifespan >=12 AND total_spending >5000 THEN 'VIP'
	 WHEN lifespan >=12 AND total_spending <=5000 THEN 'REGULAR'
	 ELSE 'NEW'
END customer_segment,
COUNT(customer_key) AS total_counting
FROM customer_spending
GROUP BY 
CASE WHEN lifespan >=12 AND total_spending >5000 THEN 'VIP'
	 WHEN lifespan >=12 AND total_spending <=5000 THEN 'REGULAR'
	 ELSE 'NEW'
END
ORDER BY total_counting DESC
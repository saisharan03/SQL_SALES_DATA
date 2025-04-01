--group the data based on a specific range.
--helps understand the correlation between two measures.
--segment products into cost ranges and count how many products fall into each segment.

WITH segmentation AS (
SELECT 
product_key,
product_name,
cost,
CASE WHEN cost <100 THEN 'Below 100'
	 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
	 WHEN cost BETWEEN 500 AND 1000 THEN  '500-1000'
	 ELSE 'Above 1000'
END cost_range 
FROM "gold.dim_products")

SELECT 
cost_range,
COUNT(product_key) AS total_products
FROM segmentation
GROUP BY cost_range
ORDER BY total_products DESC
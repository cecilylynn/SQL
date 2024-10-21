-- Pharmacy Analytics (Part 2) (CVS Health SQL Interview Question)
-- https://datalemur.com/questions/non-profitable-drugs

-- CVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market. 
-- Each drug is exclusively manufactured by a single manufacturer.

-- Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS 
-- Health and calculate the total amount of losses incurred.

-- Output the manufacturer's name, the number of drugs associated with losses, and the total losses in 
-- absolute value. Display the results sorted in descending order with the highest losses displayed at the top.



SELECT manufacturer
  , COUNT( DISTINCT product_id) AS drug_count
  , ABS(SUM(total_sales - cogs)) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC
;
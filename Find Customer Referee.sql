-- 584. Find Customer Referee
-- https://leetcode.com/problems/find-customer-referee/?envType=study-plan-v2&envId=top-sql-50

/*
Find the names of the customer that are not referred by the customer with id = 2.

Return the result table in any order.
*/

SELECT name
FROM customer
WHERE referee_id != 2 OR referee_id IS NULL 
;
-- Who Made Quota? (Oracle SQL Interview Question)
-- https://datalemur.com/questions/oracle-sales-quota

-- As a data analyst on the Oracle Sales Operations team, you are given a list of salespeople’s deals, 
-- and the annual quota they need to hit.

-- Write a query that outputs each employee id and whether they hit the quota or not ('yes' or 'no'). 
-- Order the results by employee id in ascending order.

-- Definitions:
--   deal_size: Deals acquired by a salesperson in the year. Each salesperson may have more than 1 deal.
--   quota: Total annual quota for each salesperson.

SELECT d.employee_id
  , (
      CASE 
        WHEN sales >= quota THEN 'yes' 
        ELSE 'no' 
        END
      ) AS made_quota
FROM (
    SELECT employee_id
      , SUM(deal_size) AS sales 
      FROM deals 
      GROUP BY employee_id
    ) AS d
  LEFT JOIN sales_quotas AS s
  ON d.employee_id = s.employee_id
ORDER BY d.employee_id ASC
;
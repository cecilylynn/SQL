-- Patient Support Analysis (Part 1) (UnitedHealth SQL Interview Question)
-- https://datalemur.com/questions/frequent-callers

-- UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to 
-- call an advocate and receive support for their health care needs – whether that's claims and benefits support, 
-- drug coverage, pre- and post-authorisation, medical records, emergency assistance, or member portal services.

-- Write a query to find how many UHG policy holders made three, or more calls, assuming each call is 
-- identified by the case_id column.

WITH frequent_callers AS (
  SELECT policy_holder_id
  FROM callers
  GROUP BY 1
  HAVING COUNT(DISTINCT case_id) >= 3
)
SELECT COUNT(policy_holder_id) AS policy_holder_count
FROM frequent_callers
;
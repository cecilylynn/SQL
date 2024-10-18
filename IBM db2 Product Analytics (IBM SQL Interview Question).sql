-- IBM db2 Product Analytics (IBM SQL Interview Question)
-- https://datalemur.com/questions/sql-ibm-db2-product-analytics

-- IBM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by 
-- their employees. The objective is to generate data to populate a histogram that shows the number of unique 
-- queries run by employees during the third quarter of 2023 (July to September). Additionally, it should count 
-- the number of employees who did not run any queries during this period.

-- Display the number of unique queries as histogram categories, along with the count of employees who executed 
-- that number of unique queries.


--first, set up a CTE for the number of distinct queries per employee in Q3
WITH employee_queries AS
  (
  SELECT e.employee_id AS eid
    , COUNT(DISTINCT query_id) AS unique_queries
  FROM employees as e
    LEFT JOIN queries as q
    ON e.employee_id = q.employee_id
      AND q.query_starttime >= '2023-07-01' 
      AND q.query_starttime < '2023-10-01' 
  GROUP BY e.employee_id
  )
--then bin the employees by the number of queries
SELECT unique_queries
  , COUNT(DISTINCT eid) as employee_count
FROM employee_queries
GROUP BY unique_queries
;
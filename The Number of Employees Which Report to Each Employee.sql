-- 1731. The Number of Employees Which Report to Each Employee
-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/?envType=study-plan-v2&envId=top-sql-50

/*
Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.
*/

SELECT managers.employee_id AS employee_id
    , managers.name AS name
    , COUNT(DISTINCT employees.employee_id) AS reports_count
    , ROUND(AVG(employees.age),0) AS average_age
FROM employees
    LEFT JOIN employees AS managers
        ON employees.reports_to = managers.employee_id
WHERE managers.employee_id IS NOT NULL
GROUP BY managers.employee_id
ORDER BY managers.employee_id
;
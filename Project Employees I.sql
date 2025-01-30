-- 1075. Project Employees I
-- https://leetcode.com/problems/project-employees-i/?envType=study-plan-v2&envId=top-sql-50

/*
Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
 

Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

Return the result table in any order.
*/

SELECT p.project_id
    , ROUND(SUM(experience_years)/COUNT(DISTINCT p.employee_id), 2) AS average_years
FROM project AS p
    LEFT JOIN employee AS e
        ON p.employee_id = e.employee_id
GROUP BY project_id
;
-- Well Paid Employees (FAANG SQL Interview Question)
-- https://datalemur.com/questions/sql-well-paid-employees

-- Companies often perform salary analyses to ensure fair compensation practices. 
-- One useful analysis is to check if there are any employees earning more than their direct managers.

-- As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. 
-- The result should include the employee's ID and name.


SELECT e.employee_id as employee_id
  , e.name as employee_name
FROM employee AS e
  LEFT JOIN employee AS m --m for manager
  ON e.manager_id = m.employee_id --joining each employee's manager to the employee
WHERE e.manager_id IS NOT NULL
  AND e.salary > m.salary
;
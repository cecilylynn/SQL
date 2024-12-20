-- Department vs. Company Salary (FAANG SQL Interview Question)
-- https://datalemur.com/questions/sql-department-company-salary-comparison

/*
You work as a data analyst for a FAANG company that tracks employee salaries over time. 
The company wants to understand how the average salary in each department compares to the 
company's overall average salary each month.

Write a query to compare the average salary of employees in each department to the company's 
average salary for March 2024. Return the comparison result as 'higher', 'lower', or 'same' 
for each department. Display the department ID, payment month (in MM-YYYY format), 
and the comparison result.
*/

/*CTEs*/
--get the payments and departments in the same table
WITH payments AS (
  SELECT e.employee_id
    , s.payment_date
    , s.amount
    , e.department_id
  FROM salary AS s
    LEFT JOIN employee AS e ON s.employee_id=e.employee_id 
)
--get the monthly department average pay
, dept_payments AS (
  SELECT department_id
    , payment_date
    , ROUND(AVG(amount),2) AS dept_avg
  FROM payments
  GROUP BY 1,2
)
--get the monthly company average pay
, company_payments AS(
SELECT payment_date
  , ROUND(AVG(amount),2) AS company_avg
FROM payments
GROUP BY 1
)
/*end CTEs*/
--bring together the department and company monthly average pay for comparison
SELECT department_id
  , TO_CHAR(d.payment_date, 'MM-YYYY') AS payment_date
  , CASE
      WHEN dept_avg<company_avg THEN 'lower'
      WHEN dept_avg>company_avg THEN 'higher'
      ELSE 'same'
    END AS comparison
FROM dept_payments AS d
  LEFT JOIN company_payments AS c ON d.payment_date=c.payment_date
WHERE TO_CHAR(d.payment_date, 'MM-YYYY')='03-2024' --just take March 2024
ORDER BY department_id
;
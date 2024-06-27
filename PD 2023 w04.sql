-- Preppin' Data 2023 Week 04

--------------------------
-- challenge can be found at
-- https://preppindata.blogspot.com/2023/01/2023-week-4-new-customers.html
------------------

-- We want to stack the tables on top of one another, since they have the same fields in each sheet. We can do this one of 2 ways:
    -- Drag each table into the canvas and use a union step to stack them on top of one another
    -- Use a wildcard union in the input step of one of the tables
-- Some of the fields aren't matching up as we'd expect, due to differences in spelling. Merge these fields together
-- Make a Joining Date field based on the Joining Day, Table Names and the year 2023
-- Now we want to reshape our data so we have a field for each demographic, for each new customer (help)
-- Make sure all the data types are correct for each field
-- Remove duplicates (help)
    -- If a customer appears multiple times take their earliest joining date
------------------------------------------------------------------------------------------------------------------------------------

--take a look at one of the tables
SELECT *
FROM pd2023_wk04_january
;

--union all the tables as a cte
WITH new_customers as (
SELECT *
    , '01' as Month
FROM pd2023_wk04_january
UNION ALL
SELECT *
    , '02' as Month
FROM pd2023_wk04_february
UNION ALL
SELECT *
    , '03' as Month
FROM pd2023_wk04_march
UNION ALL
SELECT *
    , '04' as Month
FROM pd2023_wk04_april
UNION ALL
SELECT *
    , '05' as Month
FROM pd2023_wk04_may
UNION ALL
SELECT *
    , '06' as Month
FROM pd2023_wk04_june
UNION ALL
SELECT *
    , '07' as Month
FROM pd2023_wk04_july
UNION ALL
SELECT *
    , '08' as Month
FROM pd2023_wk04_august
UNION ALL
SELECT *
    , '09' as Month
FROM pd2023_wk04_september
UNION ALL
SELECT *
    , '10' as Month
FROM pd2023_wk04_october
UNION ALL
SELECT *
    , '11' as Month
FROM pd2023_wk04_november
UNION ALL
SELECT *
    , '12' as Month
FROM pd2023_wk04_december
)

--format the unioned table as a CTE
, unioned as (
SELECT ID
    , date_from_parts(2023,month,joining_day) as joining_date
    , demographic
    , value
FROM new_customers
)

--do the pivot
, pivoted as (
SELECT id
    , joining_date
    , ethnicity
    , date_of_birth::Date as date_of_birth
    , account_type
    , ROW_NUMBER() OVER(PARTITION BY id ORDER BY joining_date ASC) as rn
FROM unioned PIVOT
    (MAX(value) FOR demographic IN ('Ethnicity','Account Type','Date of Birth')
    ) AS p
    (id
    , joining_date
    , ethnicity
    , account_type
    , date_of_birth)
    )
SELECT id, joining_date, ethnicity, date_of_birth, account_type
FROM pivoted
where rn = 1
;
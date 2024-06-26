-- Preppin' Data 2023 Week 03

--------------------------
--challenge can be found at https://preppindata.blogspot.com/2023/01/2023-week-3-targets-for-dsb.html
------------------

-- For the transactions file:
    -- Filter the transactions to just look at DSB (help)
        -- These will be transactions that contain DSB in the Transaction Code field
    -- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values
    -- Change the date to be the quarter (help)
    -- Sum the transaction values for each quarter and for each Type of Transaction (Online or In-Person) (help)
-- For the targets file:
    -- Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter (help)
    -- Rename the fields
    -- Remove the 'Q' from the quarter field and make the data type numeric (help)
-- Join the two datasets together (help)
    -- You may need more than one join clause!
-- Remove unnecessary fields
-- Calculate the Variance to Target for each row 

--look at the available tables
SELECT *
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK03_TARGETS
;

SELECT *
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
;

--set up the transactions file as a CTE
WITH transactions AS (
    SELECT SUM(value) as VALUE
        , CASE 
            WHEN online_or_in_person = 1
            THEN 'Online'
            ELSE 'In-Person'
            END as online_or_in_person
        , QUARTER(DATE(transaction_date,'DD/MM/YYYY HH:Mi:SS')) as quarter
    FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
    WHERE CONTAINS(transaction_code, 'DSB')
    GROUP BY ALL
),
--set up the targets file as a CTE
targets AS (
    SELECT online_or_in_person
        , replace(quarter, 'Q', '') as quarter --we just want the quarter number
        , target
    FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK03_TARGETS
    --we need to get a column for the quarters and a column for the targets instead of the targets in separate columns for each quarter
    UNPIVOT (target FOR quarter IN (Q1,Q2,Q3,Q4))
    )
SELECT ta.online_or_in_person
    , ta.quarter
    , tr.value
    , ta.target as quarterly_targets
    , value-quarterly_targets as variance_to_target
FROM transactions tr LEFT JOIN targets ta 
    ON ta.online_or_in_person = tr.online_or_in_person
    AND ta.quarter = tr.quarter
;
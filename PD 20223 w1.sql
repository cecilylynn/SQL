-- Preppin' Data 2023 Week 01
-- httpspreppindata.blogspot.com2023012023-week-1-data-source-bank.html

-- Split the Transaction Code to extract the letters at the start of the transaction code. These identify the bank who processes the transaction 
    -- Rename the new field with the Bank code 'Bank'. 
-- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values. 
-- Change the date to be the day of the week
-- Different levels of detail are required in the outputs. You will need to sum up the values of the transactions in three ways
    -- 1. Total Values of Transactions by each bank
    -- 2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
    -- 3. Total Values by Bank and Customer Code


--getting a look at the table
SELECT 
FROM PD2023_WK01
;

-- 1. Total Values of Transactions by each bank
SELECT split_part(transaction_code,'-',1) as Bank
     , sum(value) as Total_Value
FROM pd2023_wk01
GROUP BY 1
;

-- 2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
SELECT split_part(transaction_code,'-',1) as Bank
     , SUM(VALUE) as Total_Value
     , DAYNAME(DATE(transaction_date,'DDMMYYYY HHMiSS'))
     , CASE
        WHEN online_or_in_person=1 THEN 'Online'
        WHEN online_or_in_person=2 THEN 'In Person'
        END
        as Transaction_Type
FROM pd2023_wk01
GROUP BY ALL
;

-- 3. Total Values by Bank and Customer Code
SELECT split_part(transaction_code,'-',1) as Bank
     , SUM(VALUE) as Total_Value
     , CUSTOMER_CODE
FROM pd2023_wk01
GROUP BY ALL
;



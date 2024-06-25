--------------------------
--challenge found at https://preppindata.blogspot.com/2023/01/2023-week-2-international-bank-account.html
------------------

/*
Requirements
Input the data
In the Transactions table, there is a Sort Code field which contains dashes. We need to remove these so just have a 6 digit string
Use the SWIFT Bank Code lookup table to bring in additional information about the SWIFT code and Check Digits of the receiving bank account
Add a field for the Country Code
Hint: all these transactions take place in the UK so the Country Code should be GB
Create the IBAN as above
Hint: watch out for trying to combine sting fields with numeric fields - check data types
Remove unnecessary fields
Output the data
*/


--get a look at the swift codes table
SELECT *
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_SWIFT_CODES
;

--get a look at the transactions table
SELECT *
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_TRANSACTIONS
;

--join the tables
SELECT t.transaction_id
    , 'GB'
        || s.check_digits 
        || s.swift_code 
        || replace(sort_code, '-', '') 
        || t.account_number
        as IBAN
FROM pd2023_wk02_transactions as t
    LEFT JOIN pd2023_wk02_swift_codes as s on t.bank = s.bank
;

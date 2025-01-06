-- Repeated Payments (Stripe SQL Interview Question)
-- https://datalemur.com/questions/repeated-payments

/*
Sometimes, payment transactions are repeated by accident; it could be due to user error, API failure 
or a retry error that causes a credit card to be charged twice.

Using the transactions table, identify any payments made at the same merchant with the same credit 
card for the same amount within 10 minutes of each other. Count such repeated payments.

Assumptions:
The first transaction of such payments should not be counted as a repeated payment. 
This means, if there are two transactions performed by a merchant with the same credit card 
and for the same amount within 10 minutes, there will only be 1 repeated payment.
*/

WITH payments AS (
  SELECT *
    , (EXTRACT(EPOCH FROM --get, in seconds, the result of...
      transaction_timestamp - --...subtract the previous timestamp from the current one
      LAG(transaction_timestamp) OVER ( --Find the previous timestamp...
      PARTITION BY merchant_id, credit_card_id, amount --...for the same amount on the same card at the same merchant
      ORDER BY transaction_timestamp ASC))/60) --divide by 60 for minutes
      AS minutes
  FROM transactions
)
SELECT COUNT(DISTINCT transaction_id) AS payment_count
FROM payments
WHERE minutes <=10
;
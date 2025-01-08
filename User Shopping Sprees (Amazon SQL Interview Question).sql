-- User Shopping Sprees (Amazon SQL Interview Question)
-- https://datalemur.com/questions/amazon-shopping-spree

/*
In an effort to identify high-value customers, 
Amazon asked for your help to obtain data about users who go on shopping sprees. 
A shopping spree occurs when a user makes purchases on 3 or more consecutive days.

List the user IDs who have gone on at least 1 shopping spree in ascending order.
*/



SELECT DISTINCT t1.user_id
FROM transactions AS t1
  INNER JOIN transactions AS t2
    ON DATE(t1.transaction_date) + 1 = DATE(t2.transaction_date)
      AND t1.user_id=t2.user_id
  INNER JOIN transactions AS t3
    ON DATE(t2.transaction_date) + 1 = DATE(t3.transaction_date)
      AND t2.user_id = t3.user_id
ORDER BY t1.user_id
;
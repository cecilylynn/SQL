-- Laptop vs. Mobile Viewership (New York Times SQL Interview Question)

--https://datalemur.com/questions/laptop-mobile-viewership

-- This is the same question as problem #3 in the SQL Chapter of Ace the Data Science Interview!
-- Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.
-- Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.

SELECT 
  COUNT (CASE
    WHEN device_type = 'laptop' THEN 1
  END) AS laptop_views
  , COUNT (CASE
    WHEN device_type = 'tablet' THEN 1
    WHEN device_type = 'phone' THEN 1
  END) AS mobile_views
FROM viewership
;
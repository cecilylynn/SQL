-- International Call Percentage (Verizon SQL Interview Question)
-- https://datalemur.com/questions/international-call-percentage

/*
A phone call is considered an international call when the person calling is in a different 
country than the person receiving the call.

What percentage of phone calls are international? Round the result to 1 decimal.

Assumption:
-The caller_id in phone_info table refers to both the caller and receiver.
*/

WITH all_calls AS ( --this CTE gets all the calls with the countries of the caller and receiver
  SELECT phone_calls.*
    , caller_info.country_id AS caller_country
    , receiver_info.country_id AS receiver_country
  FROM phone_calls
    LEFT JOIN phone_info AS caller_info
      ON phone_calls.caller_id = caller_info.caller_id
    LEFT JOIN phone_info AS receiver_info
      ON phone_calls.receiver_id = receiver_info.caller_id
)
, international_calls AS ( --this CTE gets just the international calls
SELECT *
FROM all_calls
WHERE caller_country != receiver_country 
)
SELECT ROUND(100.0* --format as decimal rounded to 1 place
    (SELECT COUNT(*) from international_calls) --the number of international calls
    /COUNT(*) --divided by the total number of calls
    , 1) AS international_calls_pct
FROM all_calls
;













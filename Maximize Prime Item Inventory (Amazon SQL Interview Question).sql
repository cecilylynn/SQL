-- Maximize Prime Item Inventory (Amazon SQL Interview Question)
-- https://datalemur.com/questions/prime-warehouse-storage

/*
Amazon wants to maximize the storage capacity of its 500,000 square-foot warehouse by prioritizing a 
specific batch of prime items. The specific prime product batch detailed in the inventory table must 
be maintained.

So, if the prime product batch specified in the item_category column included 1 laptop and 1 side table, 
that would be the base batch. We could not add another laptop without also adding a side table; 
they come all together as a batch set.

After prioritizing the maximum number of prime batches, any remaining square footage will be utilized 
to stock non-prime batches, which also come in batch sets and cannot be separated into individual items.

Write a query to find the maximum number of prime and non-prime batches that can be stored 
in the 500,000 square feet warehouse based on the following criteria:

Prioritize stocking prime batches
After accommodating prime items, allocate any remaining space to non-prime batches
Output the item_type with prime_eligible first followed by not_prime, 
along with the maximum number of batches that can be stocked.

Assumptions:
  Again, products must be stocked in batches, so we want to find the largest available quantity of 
  prime batches, and then the largest available quantity of non-prime batches
  Non-prime items must always be available in stock to meet customer demand, 
so the non-prime item count should never be zero.
  Item count should be whole numbers (integers).
*/

WITH batch_areas AS (
  SELECT item_type
    , SUM(square_footage) AS batch_area
    , COUNT(item_id) AS item_count
  FROM inventory
  GROUP BY item_type
)
, prime_batches AS(
  SELECT FLOOR( --take the floor so we get a whole number of batches
      (500000-(SELECT batch_area FROM batch_areas WHERE item_type='not_prime'))--subtract the space of one non-prime batch so we know we have room for it later
      /batch_area) AS num_batches
    , 500000-batch_area*(FLOOR( --take the floor so we get a whole number of batches
      (500000-(SELECT batch_area FROM batch_areas WHERE item_type='not_prime'))--subtract the space of one non-prime batch so we know we have room for it later
      /batch_area)) AS remaining_area
    , item_count*FLOOR( --take the floor so we get a whole number of batches
      (500000-(SELECT batch_area FROM batch_areas WHERE item_type='not_prime'))--subtract the space of one non-prime batch so we know we have room for it later
      /batch_area) AS item_count
    , item_type
  FROM batch_areas
  WHERE item_type='prime_eligible'
)
, not_prime_batches AS(
  SELECT FLOOR((SELECT remaining_area FROM prime_batches)/batch_area) AS num_batches
    , item_type
    , item_count*FLOOR((SELECT remaining_area FROM prime_batches)/batch_area) AS item_count
  FROM batch_areas
  WHERE item_type = 'not_prime'
)
SELECT item_type
  , item_count
FROM not_prime_batches 
UNION 
SELECT item_type
  , item_count
FROM prime_batches
ORDER BY item_count DESC
;


















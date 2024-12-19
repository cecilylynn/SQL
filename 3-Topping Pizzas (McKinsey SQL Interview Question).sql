-- 3-Topping Pizzas (McKinsey SQL Interview Question)
-- https://datalemur.com/questions/pizzas-topping-cost

/*
You’re a consultant for a major pizza chain that will be running a promotion where all 
3-topping pizzas will be sold for a fixed price, and are trying to understand the costs involved.

Given a list of pizza toppings, consider all the possible 3-topping pizzas, 
and print out the total cost of those 3 toppings. 
Sort the results with the highest total cost on the top followed by pizza toppings in 
ascending order.

Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, 
followed by the second and third.

P.S. Be careful with the spacing (or lack of) between each ingredient. 
Refer to our Example Output.

Notes:
*Do not display pizzas where a topping is repeated. 
For example, ‘Pepperoni,Pepperoni,Onion Pizza’.
*Ingredients must be listed in alphabetical order. 
For example, 'Chicken,Onions,Sausage'. 'Onion,Sausage,Chicken' is not acceptable.
*/



WITH toppings AS (
  SELECT topping_name
    , ingredient_cost
    , ROW_NUMBER() OVER (ORDER BY topping_name ASC)
  FROM pizza_toppings
)
SELECT CONCAT(t1.topping_name,',',t2.topping_name,',',t3.topping_name) AS pizza
  , t1.ingredient_cost+t2.ingredient_cost+t3.ingredient_cost AS total_cost
FROM toppings AS t1
  INNER JOIN toppings AS t2 ON t1.row_number<t2.row_number
  INNER JOIN toppings AS t3 ON t2.row_number<t3.row_number
ORDER BY total_cost DESC, pizza ASC
;







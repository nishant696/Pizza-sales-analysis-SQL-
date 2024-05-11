--Retrieve the total number of orders placed.
SELECT COUNT(order_id) as total_orders FROM orders

-- calculate the total revenue genrated from pizza sales 
SELECT * FROM pizzas
SELECT * FROM orders
SELECT * FROM order_details

SELECT SUM(order_details.quantity * pizzas.price) AS Revenue FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id

-- Identify the highest priced pizza
SELECT TOP 1 pizza_types.name, pizzas.price 
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
ORDER BY price DESC

-- Identify the most common pizza size ordered.
SELECT size, COUNT(order_details.order_details_id)
FROM pizzas
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY size

-- List the top 5 most ordered pizza types along with their quantities.
SELECT TOP 5 pizza_types.name, SUM(order_details.quantity) quantity
FROM pizzas 
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
 






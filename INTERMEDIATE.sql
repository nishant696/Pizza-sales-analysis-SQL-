-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT * FROM pizza_types
SELECT * FROM pizzas
SELECT * FROM order_details
SELECT * FROM orders

SELECT pizza_types.category, SUM(order_details.quantity) quantity
FROM pizzas 
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC

-- Determine the distribution of orders by hour of the day
SELECT DATEPART(HOUR, orders.time) , COUNT(order_id)
FROM orders
GROUP BY DATEPART(HOUR, orders.time)
ORDER BY DATEPART(HOUR, orders.time)

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT pizza_types.category, COUNT(pizza_types.name)
FROM pizza_types
GROUP BY (pizza_types.category)

--Group the orders by date and calculate the average number of pizzas ordered per day.
EXEC sp_rename 'orders.date', 'order_date', 'COLUMN';


select round(avg(quantity),0) from
(SELECT orders.order_date, SUM(order_details.quantity) as quantity
FROM orders
JOIN order_details ON orders.order_id = orders.order_id
GROUP BY orders.order_date) as order_detail

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name, SUM(order_details.quantity * pizzas.price) AS Revenue
FROM pizzas 
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue DESC



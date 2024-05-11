--Calculate the percentage contribution of each pizza type to total revenue.
SELECT pizza_types.category, SUM(order_details.quantity * pizzas.price)/(SELECT SUM(order_details.quantity * pizzas.price) FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id)*100 as Revenue
FROM pizzas 
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Revenue DESC

--Analyze the cumulative revenue generated over time.
select order_date, sum(revenue) over(order by order_date) as cum_rev
from
(select orders.order_date, sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas on order_details.pizza_id = pizzas.pizza_id
join orders on order_details.order_id = order_details.order_id
group by orders.order_date) as sales

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category, name, revenue
from
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as rv
from
(select pizza_types.category, pizza_types.name, sum((order_details.quantity) * pizzas.price) as revenue
from pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by  pizza_types.category, pizza_types.name) as n) as k
where rv <= 3
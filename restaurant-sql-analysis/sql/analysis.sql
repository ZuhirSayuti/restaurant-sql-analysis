USE restaurant_dataset;
SELECT * FROM orders;


#Checking for NULLs
SELECT * FROM orders WHERE order_id IS NULL OR customer_id IS NULL OR branch_id IS NULL OR order_date IS NULL;

SELECT * FROM branches WHERE branch_id IS NULL OR branch_name IS NULL OR city IS NULL;

SELECT * FROM customers WHERE customer_id IS NULL OR name IS NULL OR city IS NULL;

SELECT * FROM employees WHERE employee_id IS NULL OR name IS NULL OR branch_id IS NULL OR role IS NULL;

SELECT * FROM menu_items WHERE item_id IS NULL OR item_name IS NULL OR category IS NULL OR price IS NULL;

SELECT * FROM order_details WHERE order_detail_id IS NULL OR order_id IS NULL OR item_id IS NULL OR quantity IS NULL;

SELECT * FROM payments WHERE payment_id IS NULL OR order_id IS NULL OR method IS NULL OR amount IS NULL;


#Number of customers
SELECT COUNT(*) number_of_customers FROM customers;


#Number of branches
SELECT COUNT(*) number_of_branches FROM branches;


#Number of employees in each branch
SELECT b.branch_id, b.branch_name, COUNT(e.employee_id) number_of_employees
FROM branches b JOIN employees e ON e.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name;


#Number of menu items
SELECT COUNT(*) number_of_items FROM menu_items;


#Number of orders placed
SELECT COUNT(*) number_of_orders FROM orders;


#Count of orders of each payment method
SELECT method, COUNT(*) number_of_orders FROM payments
GROUP BY method ORDER BY COUNT(*) DESC;


#Total Revenue
SELECT SUM(amount) revenue FROM payments;


#Top Selling menu items by unit sold
SELECT RANK() OVER(ORDER BY SUM(od.quantity) DESC) ranking, i.item_id, i.item_name, SUM(od.quantity) unit_sold 
FROM menu_items i JOIN order_details od 
ON i.item_id = od.item_id
GROUP BY i.item_id ,i.item_name;


#Top Selling menu items by revenue
SELECT RANK() OVER(ORDER BY SUM(od.quantity * i.price) DESC) ranking, i.item_id, i.item_name, SUM(od.quantity * i.price) revenue
FROM menu_items i JOIN order_details od
ON i.item_id = od.item_id
GROUP BY i.item_id, i.item_name;


#Top branches by revenue
SELECT RANK() OVER(ORDER BY SUM(p.amount) DESC) ranking, b.branch_id, b.branch_name, SUM(p.amount) revenue
FROM branches b 
JOIN orders o ON b.branch_id = o.branch_id  
JOIN payments p ON o.order_id = p.order_id
GROUP BY b.branch_id, b.branch_name;


#Average order value
SELECT ROUND(AVG(p.amount), 2) average_order_value
FROM orders o JOIN payments p ON o.order_id = p.order_id;


#Top customers by orders placed 
SELECT DENSE_RANK() OVER(ORDER BY COUNT(o.order_id) DESC) ranking, c.customer_id, c.name, COUNT(o.order_id) order_placed 
FROM customers c JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.name;


#Revenue by payment method
SELECT method, SUM(amount) revenue FROM payments
GROUP BY method ORDER BY revenue DESC;


#Item categories by revenue
SELECT RANK() OVER(ORDER BY SUM(od.quantity * i.price) DESC) ranking, i.category, SUM(od.quantity * i.price) revenue
FROM menu_items i JOIN order_details od ON i.item_id = od.item_id
GROUP BY i.category;


#Monthly sales trends
SELECT MONTH(o.order_date) month, SUM(p.amount) revenue FROM 
orders o JOIN payments p ON o.order_id = p.order_id
GROUP BY MONTH(o.order_date) ORDER BY MONTH(o.order_date);


#Average items per order
SELECT ROUND(AVG(items_per_order),2) average_items_per_order 
FROM(
SELECT order_id, COUNT(item_id) items_per_order FROM order_details
GROUP BY order_id) sub;


#Top 5 customer by revenue in each branch
WITH Branch_Customer_Revenue_CTE AS
(
SELECT c.customer_id, c.name, o.branch_id, SUM(p.amount) revenue
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, o.branch_id
),
Ranking_BCRC AS(
SELECT b.branch_id, b.branch_name, bcrc.customer_id, bcrc.name, bcrc.revenue, 
DENSE_RANK() OVER(PARTITION BY b.branch_id ORDER BY bcrc.revenue DESC) ranking
FROM Branch_Customer_Revenue_CTE bcrc JOIN branches b
ON b.branch_id = bcrc.branch_id)

SELECT * FROM Ranking_BCRC
WHERE ranking <= 5;


#Busiest days of the week
SELECT DENSE_RANK() OVER(ORDER BY COUNT(order_id) DESC) ranking, DAYNAME(order_date) day, COUNT(order_id) number_of_orders
FROM orders GROUP BY DAYNAME(order_date);


#Busiest hours of the day
SELECT DENSE_RANK() OVER(ORDER BY COUNT(order_id) DESC) ranking, HOUR(order_date) hour, COUNT(order_id) number_of_orders
FROM orders GROUP BY HOUR(order_date);


#Menu items revenue by category ranking
SELECT m.item_id, m.item_name, m.category, 
DENSE_RANK() 
OVER(PARTITION BY m.category ORDER BY SUM(m.price * od.quantity) DESC) ranking, SUM(m.price * od.quantity) revenue
FROM menu_items m JOIN order_details od ON m.item_id = od.item_id
GROUP BY m.item_id, m.item_name, m.category;


#Cumulative monthly revenue
WITH Monthly_Revenue_CTE AS
(
SELECT MONTH(o.order_date) month, SUM(p.amount) revenue FROM orders o 
JOIN payments p ON o.order_id = p.order_id
GROUP BY MONTH(o.order_date) ORDER BY MONTH(o.order_date) 
)
SELECT *, SUM(revenue) OVER(ORDER BY month) cumulative_revenue
FROM Monthly_Revenue_CTE;


#Customer classification by revenue
SELECT c.customer_id, c.name, SUM(p.amount) revenue,
    CASE
        WHEN SUM(p.amount) >= 800 THEN "high"
        WHEN SUM(p.amount) > 500 THEN "medium"
        ELSE "low"
    END AS tier
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.name;

























 
/* DATABASE NORTHWIND 

Question 41. 
Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table
Query:
*/


SELECT 	product_name,	
        suppliers.company_name,
        categories.category_name
FROM 	products 	JOIN categories ON categories.category_id = products.category_id
			JOIN suppliers ON suppliers.supplier_id = products.supplier_id

/*
Question 42.
Show the category_name and the average product unit price for each category rounded to 2 decimal places.
Query:
*/


SELECT 	categories.category_name,
	ROUND(AVG(unit_price),2)
FROM    products JOIN categories ON categories.category_id = products.category_id
GROUP BY 
        category_name

/*
Question 43
Show the city, company_name, contact_name from the customers and suppliers table merged together.
Create a column which contains 'customers' or 'suppliers' depending on the table it came from.
Query:
*/

SELECT 	city, 
	company_name, 
	contact_name, 
	'customers' AS relationship 
FROM 	customers 
UNION
SELECT 	city, 
	company_name, 
	contact_name, 
        'suppliers'
FROM	suppliers

/*
Question 44.
Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late.
Order by employee last_name, then by first_name, and then descending by number of orders.
Query:
*/

SELECT
        e.first_name,
        e.last_name,
        COUNT(o.order_id) AS num_orders,
  	(CASE
      		WHEN o.shipped_date <= o.required_date THEN 'On Time'
      		ELSE 'Late'
    	END) AS shipped
FROM orders oJOIN employees e ON e.employee_id = o.employee_id
GROUP BY
  	e.first_name,
  	e.last_name,
  	shipped
ORDER BY
  	e.last_name,
  	e.first_name,
  	num_orders DESC


/*
Question 45
Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places
Query:
*/

SELECT
	YEAR(orders.order_date) AS year_disc,
	ROUND(SUM(unit_price* order_details.quantity*order_details.discount),2) AS DISCOUNT
FROM orders 	JOIN order_details ON order_details.order_id = orders.order_id
		JOIN products ON products.product_id = order_details.product_id
GROUP BY YEAR(orders.order_date)
ORDER BY year(orders.order_date) DESC

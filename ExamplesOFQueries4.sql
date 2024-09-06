/* DATABASE NORTHWIND (EASY)

Question 32. 
Show the category_name and description from the categories table sorted by category_name.

Query:
*/

SELECT 
	category_name,
        description
FROM 	categories
ORDER BY 
	category_name

/*
Question 33. 
Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'

Query:
*/

SELECT 
	contact_name,
        address,
        city
FROM 	customers
WHERE 	country NOT IN('Germany','Mexico','Spain')

/*
Question 34.
Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
Query:
*/

SELECT 
	order_date,
        shipped_date,
        customer_id,
        freight
FROM	orders
WHERE 	order_date = '2018-02-26'


/*
Question 35.
Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date

Query:
*/

SELECT 
	employee_id,
        order_id, 
        customer_id,
        required_date, 
        shipped_date
FROM 	orders
WHERE 	shipped_date > required_date

/*
Question 36.
Show all the even numbered Order_id from the orders table

Query:
*/

SELECT 
	order_id
FROM 	orders
WHERE 	order_id % 2 = 0



/*
Question 37.
Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name
Query:
*/


SELECT 
	city,
        company_name,
        contact_name
FROM	customers
WHERE 	city LIKE '%L%'
ORDER BY contact_name

/*
Question 38.
Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)

Query:
*/

SELECT 
	company_name,
        contact_name,
        fax
FROM 	customers
WHERE 	fax IS NOT NULL

/*
Question 39.
Show the first_name, last_name. hire_date of the most recently hired employee.

Query:
*/

SELECT 
	first_name,
        last_name,
        hire_date
FROM 	employees
ORDER BY hire_date DESC
LIMIT 1

/* or 
*/

SELECT
    	first_name,
    	last_name,
    	MAX(hire_date) AS hire_date
FROM  	employees

/*
Question 40.
Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table.

Query:
*/

SELECT 
	round(avg(unit_price),2),
        SUM(units_in_stock),
        SUM(discontinued)
FROM	products

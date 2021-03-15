-- Project only certain columns
select email, firstName from employees;

-- Show only certain rows that match a criteria
select * from employees where officeCode = 1;

-- Show only certain rows that match a criteria, but only some column
select firstName from employees where officeCode = 1;

-- Show only certain rows that match a string
select * from employees where jobTitle = "Sales Rep"

-- Show only certain rows that match a substring. % is a wildcard in SQL
select * from employees where jobTitle like "VP%"

-- Multi filter
select * from employees where officeCode=1 AND jobTitle = "Sales Rep";

-- Using not equal (opp filter)
select * from employees where officeCode != 1 and officeCode != 4;
select * from employees where officeCode not in (1,4);

-- Order and Priority also applies to SQL
select * from employees where officeCode = 4 or officeCode = 1 and jobTitle = "Sales Rep";

-- Join two related tables together
SELECT firstName, lastName, addressLine1, addressLine2, city, state, country, postalCode FROM employees JOIN offices ON employees.officeCode = offices.officeCode;

-- Join two related tables and filter
SELECT firstName,
         lastName,
		 jobTitle,
         addressLine1,
         addressLine2,
         city,
         state,
         country,
         postalCode
FROM employees
JOIN offices
    ON employees.officeCode = offices.officeCode
WHERE jobTitle = "Sales Rep"

-- Join more than 2 offices and project only some columns
SELECT customerName,
         customers.city,
		 firstName,
		 lastName,
		 jobTitle,
         offices.city
FROM customers
JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN offices
    ON employees.officeCode = offices.officeCode

-- Join more than 2 offices, project some columns, and include filter
SELECT customerName,
         customers.city,
         firstName,
         lastName,
         jobTitle,
         offices.city
FROM customers
JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN offices
    ON employees.officeCode = offices.officeCode
WHERE customers.city = "Paris" or customers.city = "san francisco";

-- Join more than 2 offices, project some columns, and include filter, order by name, and then limit to the first 3 results
SELECT customerName,
         customers.city,
         firstName,
         lastName,
         jobTitle,
         offices.city
FROM customers
JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN offices
    ON employees.officeCode = offices.officeCode
WHERE customers.country = "france"
        OR customers.country = "usa"
ORDER BY  customers.customerName
LIMIT 3;

-----------------|
----- DATES -----|
-----------------|
-- Find orders where orderdate is earlier than 9 Jun 2003
SELECT * FROM orders where orderDate < "2003-06-09"

-- Find all orders made in year 2003
SELECT *
FROM orders
WHERE YEAR(orderDate) = 2003;

-- Shows current date on server
SELECT CURRDATE()

-- HANDS ON
-- Q1: Find all the offices and display only their city, phone and country.
select city, phone, country from offices;

-- Q2: Find all rows in the orders table that mentions FedEx in the comments.
SELECT * FROM orders where comments like "%FedEx%";

-- Q3: Display all the orders bought by the customer with the customer number 124, along with the customer name, the contact's first name and contact's last name.
SELECT orders.customerNumber,
         customerName,
         contactFirstName,
         contactLastName,
         orderNumber,
         orderDate,
         requiredDate,
         shippedDate,
         status,
         comments
FROM orders
JOIN customers
    ON customers.customerNumber = orders.customerNumber
WHERE orders.customerNumber = 124

-- Q4: Show the contact first name and contact last name of all customers in descending order by the customer's name.
SELECT customerName,
         contactFirstName,
         contactLastName
FROM customers
ORDER BY  customerName DESC;

-- Q5: Find all sales rep who are in office code 1, 2 or 3 and their first name or last name contains the substring 'son'.
SELECT *
FROM employees
WHERE jobTitle = "Sales Rep"
        AND (officeCode in (1,2,3))
        AND (firstName LIKE "%son%"
        OR lastName LIKE "%son%")

-- Q6: Show the name of the product, together with the order details,  for each order line from the orderdetails table.
SELECT orderNumber,
         quantityOrdered,
         priceEach,
         orderLineNumber,
         orderdetails.productCode,
         productName
FROM orderdetails
JOIN products
    ON orderdetails.productCode = products.productCode;

-- Q7: Show how many employees are there for each state in the USA.
SELECT state, count(*)
FROM employees
JOIN offices
    ON employees.officeCode = offices.officeCode
WHERE country = "usa"
GROUP BY  state;

-- Q8: From the payments table, display the average amount spent by each customer. Display the name of the customer as well.
SELECT customerName, AVG(amount)
FROM payments
JOIN customers
    ON payments.customerNumber = customers.customerNumber
GROUP BY customerName


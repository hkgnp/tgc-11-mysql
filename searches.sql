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

-- HANDS ON
-- Q1
select city, phone, country from offices;

-- Q2
SELECT * FROM orders where comments like "%FedEx%";

-- Q3
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

-- Q4
SELECT customerName,
         contactFirstName,
         contactLastName
FROM customers
ORDER BY  customerName DESC;

-- Q5
SELECT *
FROM employees
WHERE jobTitle = "Sales Rep"
        AND (officeCode = 1
        OR officeCode = 2
        OR officeCode = 3)
        AND (firstName LIKE "%son%"
        OR lastName LIKE "%son%")

-- Q6
SELECT orderNumber,
         quantityOrdered,
         priceEach,
         orderLineNumber,
         orderdetails.productCode,
         productName
FROM orderdetails
JOIN products
    ON orderdetails.productCode = products.productCode;
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
WHERE customers.city = "Paris";

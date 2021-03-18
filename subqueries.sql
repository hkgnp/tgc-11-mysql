-- Find customers whose credit limit is greater than the average credit limit of all customers
SELECT customerNumber,
         creditLimit
FROM customers
WHERE creditLimit > 
    (SELECT avg(creditLimit)
    FROM customers);

-- Find all products that have not been ordered before
SELECT *
FROM products
WHERE productCode NOT IN 
    (SELECT productCode
    FROM orderdetails);

-- 1 - Display all Sales Support Agents with their first name and last name

SELECT FirstName, LastName from Employee WHERE Title = "Sales Support Agent"

-- 2 - Display all employees hired between 2002 and 2003, and display their first name and last name

SELECT FirstName, LastName, HireDate
FROM Employee
WHERE YEAR(HireDate) >= 2002 AND YEAR(HireDate) <= 2003;

-- 3 - Display all artists that have the word 'Metal' in their name

SELECT Name
FROM Artist
WHERE Name LIKE "%metal%";

-- 4 - Display all employees which are in sales (sales manager, sales rep etc.)

SELECT FirstName, LastName, Title
FROM Employee
WHERE Title LIKE "%sales%";

-- 5 - Display the titles of all tracks which has the genre "easy listening"

SELECT Track.Name, Genre.Name
FROM Track
JOIN Genre 
    ON Track.GenreId = Genre.GenreId
WHERE Genre.Name = "Easy Listening";

-- 6 - Display all the tracks from all albums along with the genre of each track

SELECT *
FROM Track
JOIN Genre
    ON Track.GenreId = Genre.GenreId;

-- 7 - Using the Invoice table, show the average payment made for each country

SELECT BillingCountry, AVG(Total)
From Invoice
GROUP BY BillingCountry;

-- 8 - Using the Invoice table, show the average payment made for each country, but only for countries that paid more than 1,000 in total

SELECT BillingCountry, AVG(Total), SUM(Total)
FROM Invoice
GROUP BY BillingCountry
HAVING SUM(Total) > 500;

-- 9 - Using the Invoice table, show the average payment made for each customer, but only for customer reside in Germany and only if that customer has paid more than 100 in total

SELECT Invoice.CustomerId, AVG(Invoice.Total), SUM(Invoice.Total), Customer.Country
FROM Invoice
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId
WHERE Customer.Country = "Germany"
GROUP BY Invoice.CustomerId, Customer.Country
HAVING SUM(Invoice.Total) > 10;

-- 10 - Display the average length of Jazz song (that is, the genre of the song is Jazz) for each album

SELECT Track.AlbumId, Album.Title, AVG(Track.Milliseconds)
FROM Track
JOIN Genre ON Track.GenreId = Genre.GenreId
JOIN Album on Track.AlbumId = Album.AlbumId
WHERE Genre.Name = "Jazz"
GROUP BY Track.AlbumId, Album.Title;
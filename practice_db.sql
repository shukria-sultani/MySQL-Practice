-- Active: 1771875585958@@127.0.0.1@3306
DROP DATABASE IF EXISTS university_database;
CREATE DATABASE little_lemmon;

use little_lemmon;

create table customers(customer_id INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE);

Insert into customers (customer_id, FullName, PhoneNumber) VALUES (1, "Vanessa McCarthy", 0757536378), (2, "Marcos Romero", 0757536379), (3, "Hiroki Yamane", 0757536376), (4, "Anna Iversen", 0757536375), (5, "Diana Pinto", 0757536374);

CREATE TABLE Bookings (BookingID INT NOT NULL PRIMARY KEY,  BookingDate DATE NOT NULL,  TableNumber INT NOT NULL, NumberOfGuests INT NOT NULL CHECK (NumberOfGuests <= 8), customer_id INT NOT NULL, FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE); 

INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, customer_id) VALUES (10, '2021-11-11', 7, 5, 1), (11, '2021-11-10', 5, 2, 2), (12, '2021-11-10', 3, 2, 4);



-- inner join

SELECT FullName,PhoneNumber,BookingDate,NumberOfGuests from customers INNER JOIN Bookings on customers.customer_id = Bookings.customer_id;
-- left join
select c.customer_id, b.BookingID from customers AS c LEFT join Bookings AS b on c.customer_id = b.customer_id;
ALTER TABLE customers RENAME To old_customers;

CREATE TABLE current_customers(customer_id INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE);

ALTER TABLE old_customers 
ADD COLUMN location VARCHAR(300);

UPDATE old_customers
SET location = "US"
WHERE customer_id = 1 OR customer_id = 2;

INSERT INTO current_customers(customer_id, FullName, PhoneNumber) VALUES (1, "Mahjabeen", 0778921456),(2, "Karim", 0789012345), (3, "Mohadisa", 0743423569), (4, "Latif", 0799078234);

ALTER TABLE current_customers
ADD COLUMN location VARCHAR(300);

UPDATE current_customers
SET location = "Afghanistan"
WHERE customer_id IN(1,3);

-- UNION OPERATOR : Used to combine the result sets of two or more SELECT queries into a single result set.
SELECT customer_id, FullName from old_customers UNION SELECT customer_id, FullName from current_customers;

-- conditional combining 

SELECT FullName, location FROM old_customers WHERE location = "US" UNION SELECT FullName, location FROM current_customers WHERE location =  "Afghanistan";

CREATE TABLE Orders(OrderID INT, Department VARCHAR(100), OrderDate DATE, OrderQty INT, OrderTotal INT, PRIMARY KEY(OrderID));

INSERT INTO Orders VALUES(1,'Lawn Care','2022-05-05',12,500),(2,'Decking','2022-05-22',150,1450),(3,'Compost and Stones','2022-05-27',20,780),(4,'Trees and Shrubs','2022-06-01',15,400),(5,'Garden Decor','2022-06-10',2,1250),(6,'Lawn Care','2022-06-10',12,500),(7,'Decking','2022-06-25',150,1450),(8,'Compost and Stones','2022-05-29',20,780),(9,'Trees and Shrubs','2022-06-10',15,400),(10,'Garden Decor','2022-06-10',2,1250),(11,'Lawn Care','2022-06-25',10,400), 
(12,'Decking','2022-06-25',100,1400),(13,'Compost and Stones','2022-05-30',15,700),(14,'Trees and Shrubs','2022-06-15',10,300),(15,'Garden Decor','2022-06-11',2,1250),(16,'Lawn Care','2022-06-10',12,500),(17,'Decking','2022-06-25',150,1450),(18,'Trees and Shrubs','2022-06-10',15,400),(19,'Lawn Care','2022-06-10',12,500),(20,'Decking','2022-06-25',150,1450),(21,'Decking','2022-06-25',150,1450);

-- Task 1: Write a SQL SELECT statement to group all records that have the same order date.
SELECT OrderDate FROM Orders GROUP BY OrderDate;

-- Task 2: Write a SQL SELECT statement to retrieve the number of orders placed on the same day.
SELECT OrderDate, COUNT(OrderDate) FROM Orders GROUP BY OrderDate;

-- Task 3: Write a SQL SELECT statement to retrieve the total order quantities placed by each department.
 SELECT Department, SUM(OrderQty) FROM Orders GROUP BY Department;

 -- Task 4: Write a SQL SELECT statement to retrieve the number of orders placed on the same day between the following dates: 1st June 2022 and 30th June 2022.

 SELECT OrderDate, COUNT(OrderDate) FROM Orders GROUP BY OrderDate HAVING OrderDate BETWEEN "2022-06-01" AND "2022-06-30";
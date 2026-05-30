-- Active: 1771875585958@@127.0.0.1@3306@little_lemmon
DROP DATABASE IF EXISTS university_database;
CREATE DATABASE little_lemmon

use little_lemmon

create table customers(customer_id INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE)

Insert into customers (customer_id, FullName, PhoneNumber) VALUES (1, "Vanessa McCarthy", 0757536378), (2, "Marcos Romero", 0757536379), (3, "Hiroki Yamane", 0757536376), (4, "Anna Iversen", 0757536375), (5, "Diana Pinto", 0757536374);

CREATE TABLE Bookings (BookingID INT NOT NULL PRIMARY KEY,  BookingDate DATE NOT NULL,  TableNumber INT NOT NULL, NumberOfGuests INT NOT NULL CHECK (NumberOfGuests <= 8), customer_id INT NOT NULL, FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE); 

INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, customer_id) VALUES (10, '2021-11-11', 7, 5, 1), (11, '2021-11-10', 5, 2, 2), (12, '2021-11-10', 3, 2, 4);



-- inner join

SELECT FullName,PhoneNumber,BookingDate,NumberOfGuests from customers INNER JOIN Bookings on customers.customer_id = Bookings.customer_id
-- left join
select c.customer_id, b.BookingID from customers AS c LEFT join Bookings AS b on c.customer_id = b.customer_id

ALTER TABLE customers RENAME To old_customers

CREATE TABLE current_customers(customer_id INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE)

ALTER TABLE old_customers 
ADD COLUMN location VARCHAR(300)

UPDATE old_customers
SET location = "US"
WHERE customer_id = 1 OR customer_id = 2

INSERT INTO current_customers(customer_id, FullName, PhoneNumber) VALUES (1, "Mahjabeen", 0778921456),(2, "Karim", 0789012345), (3, "Mohadisa", 0743423569), (4, "Latif", 0799078234)

ALTER TABLE current_customers
ADD COLUMN location VARCHAR(300)

UPDATE current_customers
SET location = "Afghanistan"
WHERE customer_id IN(1,3)

-- UNION OPERATOR : Used to combine the result sets of two or more SELECT queries into a single result set.
SELECT customer_id, FullName from old_customers UNION SELECT customer_id, FullName from current_customers

-- conditional combining 

SELECT FullName, location FROM old_customers WHERE location = "US" UNION SELECT FullName, location FROM current_customers WHERE location =  "Afghanistan"

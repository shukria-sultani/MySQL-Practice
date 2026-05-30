-- Active: 1771875585958@@127.0.0.1@3306@little_lemmon
DROP DATABASE IF EXISTS university_database;
CREATE DATABASE little_lemmon

use little_lemmon

create table customers(customer_id INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE)

Insert into customers (customer_id, FullName, PhoneNumber) VALUES (1, "Vanessa McCarthy", 0757536378), (2, "Marcos Romero", 0757536379), (3, "Hiroki Yamane", 0757536376), (4, "Anna Iversen", 0757536375), (5, "Diana Pinto", 0757536374);

CREATE TABLE Bookings (BookingID INT NOT NULL PRIMARY KEY,  BookingDate DATE NOT NULL,  TableNumber INT NOT NULL, NumberOfGuests INT NOT NULL CHECK (NumberOfGuests <= 8), customer_id INT NOT NULL, FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE); 

INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, customer_id) VALUES (10, '2021-11-11', 7, 5, 1), (11, '2021-11-10', 5, 2, 2), (12, '2021-11-10', 3, 2, 4);



-- left join

SELECT FullName,PhoneNumber,BookingDate,NumberOfGuests from customers INNER JOIN Bookings on customers.customer_id = Bookings.customer_id

select c.customer_id, b.BookingID from customers AS c LEFT join Bookings AS b on c.customer_id = b.customer_id
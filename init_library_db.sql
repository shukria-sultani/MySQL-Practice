-- Active: 1771875585958@@127.0.0.1@3306@library_database
DROP DATABASE IF EXISTS university_database; -- I have used drop to drop the university database if it was in use

CREATE DATABASE library_database;  -- CREATE statement is a DDL (Data Defination Language) it is used to create the databse itself here

USE library_database;  -- USE statement is used to tell the MySQL server what database to use. In this case, I choose the library_database

CREATE TABLE books( -- Again CREATE is used to create a table for books we specify that we want to create a table by using the word TABLE and we give it a name
    isbn VARCHAR(20) PRIMARY KEY, -- VARCHAR type is used to store the isbn because the isbn length can be variant maybe about 10 to 13 digits. To correctly hanlde leading zero and also as we are not going to perform any sort of calculation on this field, so I have used VARCAHR instead of INT or other numeric types.PRIMARY KEY is used to define the primary key in a table and in this case isbn is the primary key.
    title VARCHAR(200) NOT NULL,  -- title length is also vairant so VARCHAR is a good choice and also setting it's size or length to 200 allows as to store lengthy titles. NOT NULL is used to tell the MySQL that a particular field can be empty or without a value. So, title cannot be empty.
    genre VARCHAR(50),  -- genre is a also a text with vairant lengths so VARCHAR is a good choice
    quantity INT -- INT is used to store quantity because it is a number and we may want to perform some calculation on quantity so INT is a good choice and besides INT allow as to store large numbers. One thing more that quantity cannot be decimal so INT is the best choice.
)

CREATE TABLE members( -- CREATE creates a table by the name of members
    member_id INT PRIMARY KEY,  -- member_id is the primary key in this table and it's type is INT
    member_name VARCHAR(50) NOT NULL, --VARCHAR is used to store the member name and member_name column cannot be empty
    email VARCHAR(70) UNIQUE NOT NULL,  -- We use VARCHAR to store the email and it is set to unique by UNIQUE keyword, so two people cannot share one email and it cannot be empty or null also.
    phone_number VARCHAR(10) NOT NULL -- VARCHAR is used to store phone number becuase we are not going to do any calculation on this field and also the leading zeros should be there.
    
)

CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY, -- loan_id's type is INT and has an attribute of AUTO_INCREMENT meaning it's value is entered automatically
    member_id INT, -- member_id's type is INT and this comes from memeber table
    isbn VARCHAR(20), -- isbn's type is VARCHAR and this comes from books table
    loan_date DATE, -- loan_date's type is date this only stores the date and in this format (YYYY-MM-DD)
    return_date DATE, -- return_date's type is also date 
    
    FOREIGN KEY (member_id) -- FOREIGN KEY defines the foreing key, the fields from other tables we use in another table to create relationship
        REFERENCES members(member_id), -- REFERENCES specify where the foreign key comes from, it specifies the table in this case member_id is a field of members table
    FOREIGN KEY (isbn) -- isbn is a foreign key
        REFERENCES books(isbn) -- isbn comes from books table

)


USE library_database;

INSERT INTO books(isbn,title, genre, quantity) -- INSERT is DML (Data Manipulation Language) statement it i used to insert or add data to the tables. In this line we want to insert data into books table and in parentheses we specify to what columns of the books table we want to insert data.
VALUES  -- VALUES is used to specify the value we want to insert in each column
('123-234-234-002', '40 Laws of Love', 'phsychology', 10),
('123-234-234-003', 'The Right Time', 'phsychology', 10),
('123-234-234-004', '5 Seconds Law', 'motivational', 10);

UPDATE books
SET book_title =  "The 5 Seconds Law"
Where isbn = "123-234-234-004";
ALTER TABLE books
ADD COLUMN quantity INT AFTER genre;

UPDATE books
set quantity = 10;
UPDATE books
SET author = "Elif Shafak"
WHERE isbn = "123-234-234-002";

ALTER TABLE books
ADD COLUMN author VARCHAR(70) AFTER title;

ALTER TABLE books
CHANGE title book_title VARCHAR(100);

ALTER TABLE books
DROP COLUMN quantity;

ALTER TABLE books
MODIFY COLUMN book_title VARCHAR(300);
-- We write another insert statement and define the values to insert data in to members table
INSERT INTO members(member_id, member_name, email,phone_number)
VALUES  
(101, 'Zahra', 'zahra@gmail.com', '0764523456'),
(102, 'Ali', 'ali@gmail.com', '0764523467'),
(103, 'Mahnoor', 'mahnoor@gmail.com', '0764523406');

-- We write another insert statement and define the values to insert data in to loans  table
INSERT INTO loans(member_id, isbn, loan_date, return_date)
VALUES
(102, "123-234-234-002", '2026-02-26', '2026-03-15'),
(103, "123-234-234-002", '2026-02-26', '2026-03-15'),
(102, "123-234-234-004", '2026-02-26', '2026-03-15');

-- retrive info about all the books a member has borrowed

SELECT books.isbn, books.title, books.genre
-- SELECT is a DQL (Data Query Language) statement used to retrieve data from one or more tables.
-- Here, we want to get the isbn, title, and genre of books borrowed by a member.
FROM loans
-- FROM specifies the table to retrieve data from. 
-- We start with the loans table because it links members and books (represents the one-to-many relationship).

JOIN books ON loans.isbn = books.isbn
-- JOIN combines rows from two tables based on a related column.
-- Here, we join loans with books on the isbn to get book details for each loan.
WHERE loans.member_id = 102
-- WHERE filters the results based on a condition.
-- We only want books that have been borrowed by the member with ID 102.

-- update book quantity
UPDATE books -- UPDATE is als a DML statement and is used to change or update the data of a table
SET quantity = 30 -- SET is used to specify the new value we want to set
WHERE isbn = '123-234-234-002' -- WHERE is used to tell which row we want to update. WHERE is very important here if we remove it, it will update all the rows.


CREATE TABLE authors( --Create a table for authors with (author_id, author_name, nationality, birth_year) attributes
    author_id INT, 
    author_name VARCHAR(70),
    nationality VARCHAR(70),
    birth_year INT
);
ALTER TABLE authors -- ALTER is a a powerful DDL command that can change the structure of a table, in this case I forgot to set the author_id as the primary key so I can use ALTER to set the author_id the primary key. In the ALTER command first we need to use the keyword ALTER after use the keyword table becuase I want to alter a table, then write the name of the table in this case it is authors. After we specify what action we want to do, add column, drop column, change the data type, add or remove primary and foreign keys. In this case I want to set the author_id as the primary key so I use the ADD PRIMARY KEY command and then write the author_id.
Add PRIMARY KEY (author_id);

ALTER TABLE books -- Previously the books table was relying on author column which could lead to typos and data inconsistency so now that we have a table for author I can simpley delete the author column and then use the author_id instead.
DROP COLUMN author;

ALTER TABLE books  -- Here I use ALTER to add a new column the author_id in the books table and set it as FOREIGN KEY
  ADD COLUMN author_id INT AFTER book_title, -- this line tells MySQL to add a column named author_id with the data type INT (it is important to be INT because the author_id is INT type in authors table) and after the book_title column.
  ADD CONSTRAINT author_id_fk -- Add constraint is like a security guard to sepicify our rules or policies we want to apply for a column here as I want to have a relationship by the author_id field or set a FOREIGN KEY constraint allows us to give this relationship a custom name and help as manipulate it later in case we wanted to delete it or other scenarios. 
    FOREIGN KEY (author_id) -- This line tells MySQL to set the author_id as FOREIGN KEY
    REFERENCES authors(author_id) -- This line specifies the table that author_id comes from and that is authors
    ON UPDATE CASCADE; -- ON UPDATE CASCADE is my favorite thing about relationship it allows the author_id in both tables to update automatically in case a change is made to the id.

INSERT INTO authors (author_id, author_name, nationality, birth_year) VALUES 
(1, 'Elif Shafak', 'Turkish-British', 1971),
(2, 'Mel Robbins', 'American', 1968),
(3, 'James Clear', 'American', 1986),
(4, 'Gabriel García Márquez', 'Colombian', 1927),
(5, 'Haruki Murakami', 'Japanese', 1949);

INSERT INTO books (isbn, book_title, author_id, genre, quantity) VALUES  -- Add 10 books
('123-234-234-002', '40 Laws of Love', 1, 'Psychology', 10),
('123-234-234-003', 'The Right Time', 1, 'Psychology', 20),
('123-234-234-004', '5 Seconds Law', 2, 'Motivational', 12),
('978-0141032184', 'One Hundred Years of Solitude', 4, 'Magic Realism', 20),
('978-0345803481', 'Norwegian Wood', 5, 'Fiction', 14),
('978-1846046247', 'Atomic Habits', 3, 'Self-Help', 13),
('978-0241951446', 'The Bastard of Istanbul', 1, 'Fiction', 17),
('978-0525542728', 'The High 5 Habit', 2, 'Motivational', 9),
('978-1400079278', 'Kafka on the Shore', 5, 'Surrealism', 7),
('978-0060883287', 'Love in the Time of Cholera', 4, 'Romance', 10);

INSERT INTO members (member_id, member_name, email, phone_number) VALUES -- Add 20 members
(104, 'Ali Khan', 'ali@email.com', '0764523401'),
(105, 'Elena Rossi', 'elena@email.com', '0764523402'),
(106, 'Liam Smith', 'liam@email.com', '0764523403'),
(107, 'Sara Ahmed', 'sara@email.com', '0764523404'),
(108, 'David Chen', 'david@email.com', '0764523405'),
(109, 'Amara Diallo', 'amara@email.com', '0764523407'),
(110, 'Lucas Brown', 'lucas@email.com', '0764523408'),
(111, 'Sofia Garcia', 'sofia@email.com', '0764523409'),
(112, 'Hiroshi Tanaka', 'hiro@email.com', '0764523410'),
(113, 'Aisha Yusuf', 'aisha@email.com', '0764523411'),
(114, 'Mateo Silva', 'mateo@email.com', '0764523412'),
(115, 'Chloe Lefebvre', 'chloe@email.com', '0764523413'),
(116, 'Noah Wilson', 'noah@email.com', '0764523414'),
(117, 'Mia Johansson', 'mia@email.com', '0764523415'),
(118, 'Zane Malik', 'zane@email.com', '0764523416'),
(119, 'Isabella Martinez', 'bella@email.com', '0764523417'),
(120, 'Kevin Lee', 'kevin@email.com', '0764523418');

INSERT INTO members (member_id, member_name, email, phone_number) VALUES
(121, 'Youssef Mansour', 'youssef@email.com', '0764523419'),
(122, 'Grace O’Malley', 'grace@email.com', '0764523420'),
(123, 'Sven Lindholm', 'sven@email.com', '0764523421');

INSERT INTO loans (member_id, isbn, loan_date, return_date) VALUES -- Add some loans
(104, '123-234-234-002', '2026-03-01', '2026-03-15'),
(105, '978-0141032184', '2026-03-02', '2026-03-16'),
(106, '978-1846046247', '2026-03-02', '2026-03-16'),
(107, '978-0345803481', '2026-03-03', '2026-03-17'),
(108, '978-1400079278', '2026-03-03', '2026-03-17'),
(109, '123-234-234-003', '2026-03-04', '2026-03-18'),
(115, '978-0345803481', '2026-02-10', '2026-02-24'),
(115, '978-0141032184', '2026-02-12', '2026-02-26'),
(116, '123-234-234-002', '2026-02-14', '2026-02-28'),
(117, '978-1400079278', '2026-02-15', '2026-03-01'),
(118, '978-0525542728', '2026-02-18', '2026-03-04'),
(119, '123-234-234-003', '2026-02-20', '2026-03-06'),
(120, '978-0060883287', '2026-02-22', '2026-03-08'),
(104, '978-0241951446', '2026-02-24', '2026-03-10'),
(105, '978-1846046247', '2026-02-25', '2026-03-11');


SELECT books.book_title, books.genre  -- This query finds all the books that a certain author has written.
-- First we specify the data we need about the book, in this case I want to see the title and genre.
FROM books  -- This specify from which table I want the mentioned data,in this case from books
JOIN authors ON books.author_id  = authors.author_id -- As the purpose is to get all two types of data from two different tables, there should be a realtionship bewteen them. This line specifies the link between that table. It specifies the fields that the tables are connected accordingly (Silberschatz et al., 2020).
WHERE authors.author_name = "Elif Shafak"; -- As I want to see the books of a certain author I can specify this with the WHERE command, in this case I want to see the books of Elif Shafak.

ALTER TABLE books DROP FOREIGN KEY author_id_fk;  -- I want to delete or DROP the authors table to DROP a table first we need to delete the relationship it has with other tables, or basically remove the foreign key (Elmasri & Navathe, 2017).
DROP TABLE authors; -- Once the relationship is removed I can use the DROP command to delete the table.

SELECT members.member_name, members.email, members.phone_number -- This query helps us identify the names and contact details of members who have borrowed a specific book.
FROM members 
JOIN loans ON members.member_id = loans.member_id -- Since the information about who borrowed what is stored in the loans table, we use JOIN to link the members to their loan records (Silberschatz et al., 2020).
WHERE loans.isbn = "123-234-234-003";

ALTER TABLE members -- As the library grows, we might need to categorize our members. Here I use the ALTER command to modify the members table structure.
ADD COLUMN membership_type VARCHAR(70) AFTER phone_number; -- This line adds a new attribute called membership_type.

UPDATE members -- Once the new column is created, it will be empty (NULL) for everyone. We use the UPDATE command to actually fill in the data for specific rows.
SET membership_type =  "Basic" -- This specifies the value we want to put into the new membership_type column.
WHERE member_id = 104; -- This is very important because without the WHERE clause, every single member in the table would be changed to "Basic". This ensures we only update the specific member with ID 104 (Silberschatz et al., 2020).

use library_database

select author_name, nationality from authors
where author_name like "%ar%"

select  DISTINCT member_id loan_date from loans 
where loan_date < "2026-2-15"

select author_id As  "id" from authors

select CONCAT(book_title, " ", genre) As "book" from books

select m.member_name 
from members As m
join loans As l on m.member_id = l.member_id

-- joins
-- innerjoin

select b.isbn, b.book_title, b.quantity, l.member_id, l.loan_date from books as b 
INNER JOIN loans As l on b.isbn = l.isbn

select b.isbn, b.book_title, b.quantity, l.member_id, l.loan_date from books as b 
LEFT join loans As l on b.isbn = l.isbn

SELECT b.isbn, b.book_title, b.quantity, l.member_id, l.loan_date from books as b
RIGHT JOIN loans as l on b.isbn = l.isbn

SELECT b1.book_title As book_A_title,
b2.book_title as book_b_title, b1.author_id from books as b1
INNER join books as b2 on b1.author_id = b2.author_id
WHERE b1.isbn <> b2.isbn

-- Group By: used to group rows based on given column

SELECT genre, COUNT(genre) FROM books GROUP BY genre

SELECT genre, SUM(quantity) FROM books GROUP BY genre

-- HAVING: used to filter the data grouped data, or in simple terms used to filter the data that is generated by GROUP BY
SELECT genre, SUM(quantity) As total FROM books GROUP BY genre HAVING total > 20


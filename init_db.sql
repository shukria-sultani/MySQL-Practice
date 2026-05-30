-- Active: 1771875585958@@127.0.0.1@3306@university_database
DROP DATABASE IF EXISTS university_database;
CREATE DATABASE university_database
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

use university_database;

CREATE TABLE students(
    student_id int AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(70) UNIQUE NOT NULL,
    age TINYINT,
    grade DECIMAL(5,2) DEFAULT 0.00,
    current_course VARCHAR(50)
)

INSERT INTO students(first_name,last_name,email,age,grade,current_course)
VALUES
('Sara', 'Amini', 'sara@email.com', 20, 19.20, 'Database'),
('Ali', 'Ahmadi', 'ali@email.com', 24, 15.50, 'PHP'),
('Mina', 'Javadi', 'mina@email.com', 21, 17.00, 'Python');

SELECT * FROM students

INSERT INTO students (first_name, last_name, email)
VALUES ('رضا', 'نوری', 'reza@email.com');

SELECT first_name, last_name, current_course FROM students

SELECT *  FROM students WHERE current_course="Python"

USE library_database;
CREATE TABLE authors( 
    author_id INT, 
    author_name VARCHAR(70),
    nationality VARCHAR(70),
    birth_year INT
);
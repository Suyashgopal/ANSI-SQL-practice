# Topic: Introduction to ANSI SQL and MySQL
# Creating the company database and basic tables that will be used for practice

CREATE DATABASE IF NOT EXISTS company;
USE company;

# Table to store different departments in the company
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

# Table to store employee details
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary INT,
    city VARCHAR(50),
    dept_id INT
);

# Adding some departments for sample data
INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales'),
(4, 'Finance');

# Adding employees so we have data to run queries on
INSERT INTO employees VALUES
(101, 'Rahul', 28, 50000, 'Delhi', 2),
(102, 'Anjali', 32, 65000, 'Mumbai', 2),
(103, 'Kiran', 25, 40000, 'Delhi', 1),
(104, 'Sonu', 40, 80000, 'Pune', 3),
(105, 'Meena', 35, 55000, 'Mumbai', 4),
(106, 'Amit', 29, 47000, 'Delhi', 3),
(107, 'Pooja', 45, 90000, 'Pune', 2);

# Checking the data stored inside both tables
SELECT * FROM employees;
SELECT * FROM departments;



# Topic: SELECT, WHERE and ORDER BY

USE company;

# Getting all employee records
SELECT * FROM employees;

# Getting only the columns we need
SELECT name, salary FROM employees;

# Finding employees from Delhi
SELECT name, city FROM employees WHERE city = 'Delhi';

# Employees having salary above 50000
SELECT * FROM employees WHERE salary > 50000;

# Showing employees with highest salary first
SELECT name, salary FROM employees ORDER BY salary DESC;

# Arranging names alphabetically
SELECT name FROM employees ORDER BY name ASC;



# Topic: Filtering data

USE company;

# Checking multiple conditions together
SELECT * FROM employees WHERE city = 'Delhi' AND salary > 45000;

# Getting records matching any one condition
SELECT * FROM employees WHERE city = 'Pune' OR city = 'Mumbai';

# Removing Delhi employees from result
SELECT * FROM employees WHERE NOT city = 'Delhi';

# Finding employees within an age range
SELECT name, age FROM employees WHERE age BETWEEN 25 AND 35;

# Searching from multiple possible values
SELECT * FROM employees WHERE city IN ('Delhi', 'Pune');

# Finding names starting with letter A
SELECT name FROM employees WHERE name LIKE 'A%';

# Sorting first by city then salary
SELECT name, city, salary FROM employees ORDER BY city ASC, salary DESC;



# Topic: Aggregate functions and GROUP BY

USE company;

# Total number of employees
SELECT COUNT(*) FROM employees;

# Total salary amount and average salary
SELECT SUM(salary) AS total_salary, AVG(salary) AS avg_salary FROM employees;

# Highest and lowest salaries
SELECT MAX(salary) AS highest, MIN(salary) AS lowest FROM employees;

# Counting employees from each city
SELECT city, COUNT(*) AS total FROM employees GROUP BY city;

# Average salary of every department
SELECT dept_id, AVG(salary) AS avg_sal FROM employees GROUP BY dept_id;

# Filtering grouped results
SELECT city, COUNT(*) AS total FROM employees GROUP BY city HAVING COUNT(*) > 1;



# Topic: Joins and Subqueries

USE company;

# Combining employees with their department names
SELECT e.name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

# Showing all employees even if department is not found
SELECT e.name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

# Showing all departments even if no employee exists
SELECT e.name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

# Making all possible combinations of employees and departments
SELECT e.name, d.dept_name 
FROM employees e 
CROSS JOIN departments d;

# Comparing employees from the same table
SELECT a.name, b.name, a.city
FROM employees a, employees b
WHERE a.city = b.city AND a.emp_id < b.emp_id;

# Employees earning more than company average
SELECT name, salary FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

# Finding employees from the IT department
SELECT name FROM employees
WHERE dept_id IN (
    SELECT dept_id 
    FROM departments 
    WHERE dept_name = 'IT'
);



# Topic: INSERT, UPDATE and DELETE

USE company;

# Adding a new employee
INSERT INTO employees VALUES (108, 'Vikram', 31, 52000, 'Chennai', 1);

# Adding only selected employee details
INSERT INTO employees (emp_id, name, dept_id) VALUES (109, 'Neha', 2);

# Changing salary of one employee
UPDATE employees SET salary = 60000 WHERE emp_id = 103;

# Giving salary increase to Delhi employees
UPDATE employees SET salary = salary + 5000 WHERE city = 'Delhi';

# Removing one employee
DELETE FROM employees WHERE emp_id = 109;

# Removing employees below given salary
DELETE FROM employees WHERE salary < 45000;

# Checking updated employee data
SELECT * FROM employees;



# Topic: Creating and changing tables

USE company;

# Creating a separate table for projects
CREATE TABLE projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(50),
    budget INT
);

# Adding a new column
ALTER TABLE projects ADD start_date DATE;

# Changing column datatype
ALTER TABLE projects MODIFY budget BIGINT;

# Renaming a column
ALTER TABLE projects CHANGE proj_name project_title VARCHAR(80);

# Removing a column
ALTER TABLE projects DROP COLUMN start_date;

# Deleting the complete table
DROP TABLE projects;



# Topic: Constraints and Indexes

USE company;

# Creating table with common rules on columns
CREATE TABLE students (
    roll_no INT PRIMARY KEY,
    email VARCHAR(50) UNIQUE,
    name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

# Adding students data
INSERT INTO students VALUES (1, 'a@mail.com', 'Ravi', 20, 2);
INSERT INTO students VALUES (2, 'b@mail.com', 'Sita', 22, 1);

# Creating index for faster searching by name
CREATE INDEX idx_name ON students(name);

# Removing the index
DROP INDEX idx_name ON students;
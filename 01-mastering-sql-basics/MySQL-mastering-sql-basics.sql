-- to list all the database
SHOW DATABASES;

-- create database
CREATE DATABASE MySqlLearning;

-- to list all the database
SHOW DATABASES;

-- again create database if already created throws error
CREATE DATABASE MySqlLearning;

-- again create on conditional basis
CREATE DATABASE IF NOT EXISTS MySqlLearning;

-- use required database
USE MySqlLearning;

-- currently selected database name
SELECT database();

-- list all the tables in currently selected database
SHOW TABLES;

-- create table || constraints (NOT NULL, PRIMARY KEY) || IDENTITY(1,1)
CREATE TABLE Employee (
	-- Id INT IDENTITY(1,1),
	Id INT AUTO_INCREMENT PRIMARY KEY,
	FirstName VARCHAR(48) NOT NULL,
	LastName VARCHAR(48) NOT NULL,
	Age INT NOT NULL,
	Salary INT NOT NULL,
	Location VARCHAR(48) NOT NULL
	-- composite primary key
	-- PRIMARY KEY (Id, FirstName)
);

-- list all the tables in currently selected database
SHOW TABLES;

-- description of table
DESCRIBE Employee;
DESC Employee;

-- insert data manually
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Ram', 'Kumar', 25, 200000, 'Bengaluru');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Samba', 'Sivarao', 40, 800000, 'Bengaluru');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Pallavi', 'Venkatesh', 35, 300000, 'Noida');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Manish', 'Vellu', 22, 50000, 'Delhi');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Harshitha', 'Prakash', 25, 30000, 'Gurugram');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Guru', 'Bahadur', 25, 150000, 'Pune');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Sarath', 'Narayana', 25, 175000, 'Bengaluru');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Nirikshith', 'Lingesh', 25, 550000, 'Noida');

-- select table
SELECT * FROM Employee;

-- delete table
DROP TABLE Employee;

-- employee having salary more than 1,00,000 (flow => FROM -> WHERE -> SELECT)
SELECT * FROM Employee WHERE Salary > 100000;
SELECT FirstName, LastName FROM Employee WHERE Salary > 100000;

-- employee having age greater than 25 years
SELECT FirstName, LastName FROM Employee WHERE Age > 25;

-- update LastName of employee having Id = 2 to 'Sivarao Velnati'
-- difference between UPDATE and ALTER TABLE is, UPDATE is for modify a record and ALTER TABLE is for modifying a table
-- UPDATE is DML (Data Manipulation Language) and ALTER TABLE is DDL (Data Definition Language)
-- good to enable safe update mode (update can be done only if filtering is being done by Primary key or Unique values)
UPDATE Employee SET LastName = 'Sivarao Velnati' WHERE FirstName = 'Samba'; -- not execute in safe mode
SELECT * FROM Employee;
UPDATE Employee SET LastName = 'Sivarao Velnati' WHERE Id = 2;
SELECT * FROM Employee;

-- delete record having Id = 4
DELETE FROM Employee WHERE Id = 4;
SELECT * FROM Employee;
--to list all the database
SELECT * from sys.databases;

--create database
CREATE DATABASE TSqlLearning;

--to list all the database
SELECT * from sys.databases;

--again create database if already created throws error
CREATE DATABASE TSqlLearning;

--again create on conditional basis
IF NOT EXISTS(SELECT name FROM sys.databases WHERE name = 'TSqlLearning')
	BEGIN
		CREATE DATABASE TSqlLearning;
		PRINT 'database created successfully';
	END
ELSE
	BEGIN
		PRINT 'database already exists';
	END

--use required database
USE TSqlLearning;

--currently selected database name
SELECT DB_NAME() AS CurrentDatabase;

--list all the tables in currently selected database
SELECT * FROM sys.tables;

--create table || constraints (NOT NULL, PRIMARY KEY) || IDENTITY(1,1)
CREATE TABLE Employee (
	--Id INT IDENTITY(1,1),
	Id INT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(48) NOT NULL,
	LastName NVARCHAR(48) NOT NULL,
	Age INT NOT NULL,
	Salary INT NOT NULL,
	Location NVARCHAR(48) NOT NULL
	--composite primary key
	--CONSTRAINT PK_Employee PRIMARY KEY(Id, FirstName)
);

--list all the tables in currently selected database
SELECT * FROM sys.tables;

--description of table using sp_help
EXEC sp_help Employee;
--description of table using INFORMATION_SCHEMA 
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Employee';
--description of table using sys.tables and sys.columns 
SELECT * FROM sys.tables AS t
INNER JOIN sys.columns AS c
ON t.object_id = c.object_id;

--insert data manually
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Ram', 'Kumar', 25, 200000, 'Bengaluru');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Samba', 'Sivarao', 40, 800000, 'Bengaluru');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Pallavi', 'Venkatesh', 35, 300000, 'Noida');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Manish', 'Vellu', 22, 50000, 'Delhi');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Harshitha', 'Prakash', 25, 30000, 'Gurugram');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Guru', 'Bahadur', 25, 150000, 'Pune');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Sarath', 'Narayana', 25, 175000, 'Bengaluru');
INSERT INTO Employee (FirstName, LastName, Age, Salary, Location) VALUES ('Nirikshith', 'Lingesh', 25, 550000, 'Noida');

--select table
SELECT * FROM Employee;

--delete table
--DROP TABLE Employee;

--employee having salary more than 1,00,000 (flow => FROM -> WHERE -> SELECT)
SELECT * FROM Employee WHERE Salary > 100000;
SELECT FirstName, LastName FROM Employee WHERE Salary > 100000;

--employee having age greater than 25 years
SELECT FirstName, LastName FROM Employee WHERE Age > 25;

--update LastName of employee having Id = 2 to 'Sivarao Velnati'
--difference between UPDATE and ALTER TABLE is, UPDATE is for modify a record and ALTER TABLE is for modifying a table
--UPDATE is DML (Data Manipulation Language) and ALTER TABLE is DDL (Data Definition Language)
--good to enable safe update mode (update can be done only if filtering is being done by Primary key or Unique values)
UPDATE Employee SET LastName = 'Sivarao Velnati' WHERE Id = 2;
SELECT * FROM Employee;

--delete record having Id = 4
DELETE FROM Employee WHERE Id = 4;
SELECT * FROM Employee;
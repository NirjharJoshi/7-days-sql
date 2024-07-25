SHOW DATABASES;
USE mysqllearning;

-- for each location, count of employees and average salary
SELECT * FROM employee;

SELECT Location, COUNT(Id) AS NoOfEmployee, AVG(Salary) AS AvgSalary FROM employee
GROUP BY Location;

-- for each location, count of employees and average salary
-- also FirstName, LastName of the employee
SELECT FirstName, LastName, Employee.Location, Total, Avg_Salary FROM Employee
INNER JOIN
(SELECT Location, COUNT(Id) AS Total, AVG(Salary) AS Avg_Salary FROM Employee
GROUP BY Location) AS Temp
ON Employee.Location = Temp.Location;

-- optimization => while grouping data if non-aggregated columns are also required then 
-- creating join will be computational heavy so use window function PARTITION BY
-- PARTITION BY => works similar GROUP BY but one can select non-aggregated columns as well from the table
SELECT FirstName, LastName, Location,
COUNT(Id) OVER (PARTITION BY Location) AS Total,
AVG(Salary) OVER (PARTITION BY Location) AS Avg_Salary
FROM Employee;

-- update 2 employee Salary similar to some other employee
SELECT * FROM Employee;
UPDATE Employee SET Salary = 200000 WHERE Id = 3;
UPDATE Employee SET Salary = 200000 WHERE Id = 8;
SELECT * FROM Employee;

-- get salary priority of employees
-- provide Row_Number to records based on ordering of Salary
-- using ROW_NUMBER() must required data to be sorted using ORDER BY some column
-- for same value, ROW_NUMBER() provides priority based on data created first
SELECT FirstName, LastName, Salary, 
ROW_NUMBER() OVER (ORDER BY Salary DESC) AS Priority_Salary
FROM Employee;

-- get salary priority of employees, also handle same salary should have same priority
-- RANK() can loose some ranking if there are multiple similar values
SELECT FirstName, LastName, Salary,
RANK() OVER (ORDER BY Salary DESC) AS Priority_Salary
FROM Employee;

-- get salary priority of employees, also handles same salary without loosing priority number
SELECT FirstName, LastName, Salary,
DENSE_RANK() OVER (ORDER BY Salary DESC) AS Priority_Salary
FROM Employee;

-- if there is no duplicacy in data then ROW_NUMBER(), RANK() and DENSE_RANK() will provide same result

-- record of all employees of second highest salary
SELECT * FROM employee;

SELECT * FROM 
(SELECT *, DENSE_RANK() OVER (ORDER BY Salary DESC) AS Priority_Salary FROM Employee) AS Temp
WHERE Priority_Salary = 2; 

-- first employee having second highest salary
SELECT * FROM employee;

SELECT * FROM
(SELECT *, ROW_NUMBER() OVER (ORDER BY Salary DESC) AS Priority_Salary FROM employee) AS Temp
WHERE Priority_Salary = 2;

-- details of employee having highest salary in each location
SELECT * FROM Employee;

SELECT * FROM
(SELECT *, 
ROW_NUMBER() OVER (PARTITION BY Location ORDER BY Salary DESC) AS Priority_Salary
FROM employee) AS Temp
WHERE Priority_Salary = 1;

-- https://leetcode.com/problems/rank-scores/description/
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS "rank" FROM Scores;

-- task 1 => data analysis questions

-- 1. Which courses have the highest enrollment rates?
SELECT * FROM learner;

SELECT * FROM
(SELECT c.Title, COUNT(l.Id) AS Enrolled_Learner FROM learner AS l
INNER JOIN course AS c
ON l.SelectedCourse = c.Id
GROUP BY c.Title) AS temp
ORDER BY Enrolled_Learner DESC
LIMIT 1;

SELECT * FROM learner;

SELECT * FROM 
(SELECT *, DENSE_RANK() OVER (ORDER BY Enrolled_Learners DESC) AS Top_Selling_Course FROM
(SELECT Title,
COUNT(Learner.Id) OVER (PARTITION BY SelectedCourse) AS Enrolled_Learners
FROM Learner JOIN Course ON SelectedCourse = Course.Id) AS temp) AS temp2
WHERE Top_Selling_Course = 1;

-- 2. How many learners are enrolled in each course?
SELECT * FROM Learner;

SELECT SelectedCourse, COUNT(Id) AS Enrolled_Learners FROM Learner
GROUP BY SelectedCourse;

-- 3. What is the total revenue generated from the course fees?
SELECT * FROM Learner;
SELECT * FROM Course;

SELECT SUM(t1.Price) AS Total_Revenue FROM
(SELECT c.Price FROM Learner AS l
INNER JOIN Course AS c
ON l.SelectedCourse = c.Id) AS t1;

-- 4. Which locations contribute the most to course revenue?
SELECT * FROM Learner;

SELECT l.Location, SUM(c.Price) AS Revenue_From_Locations FROM learner AS l
INNER JOIN course AS c
ON l.SelectedCourse = c.Id
GROUP BY l.Location
ORDER BY Revenue_From_Locations DESC
LIMIT 1;

-- 5. Which course contributes the most to the learner's enrollment?
SELECT * FROM learner;

SELECT SelectedCourse, COUNT(Id) AS Enrolled_Learners FROM learner
GROUP BY SelectedCourse
ORDER BY Enrolled_Learners DESC
LIMIT 1;

-- 6. Rank learners based on their enrollment date within each course.
SELECT * FROM learner;

SELECT Id, FirstName, LastName, SelectedCourse, EnrollmentDate,
DENSE_RANK() OVER (PARTITION BY SelectedCourse ORDER BY EnrollmentDate) AS Rank_Based_On_Enrollment_Date
FROM learner;

-- 7. Compare each employee’s salary with the average salary in their location.
SELECT * FROM Employee;

SELECT *, 
AVG(Salary) OVER (PARTITION BY Location) AS Average_Salary
FROM Employee;




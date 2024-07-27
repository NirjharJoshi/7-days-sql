USE mysqllearning;
SHOW TABLES;

-- CASE STATEMENT
-- create a new column named CourseFeeStatus
/*
	Price > 5000 => 'Expensive'
    Price > 3000 => 'Moderate'
    ELSE 'Pocket Friendly'
*/
SELECT * FROM course_update;

SELECT Id, Title, Duration_Months, Price, 
	CASE
		WHEN Price > 5000 THEN 'Expensive'
		WHEN Price > 2000 THEN 'Moderate'
		ELSE 'Pocket Friendly'
	END AS CourseFeeStatus
FROM course_update;

-- CASE EXPRESSION
-- CourseType => Premium, Plus, Regular
SELECT * FROM course_update;

SELECT Id, Title, Duration_Months, Price, 
	CASE Price
		WHEN 11999 THEN 'Premium Course'
        WHEN 7999 THEN 'Plus Course'
        ELSE 'Regular Course'
	END AS CourseType
FROM course_update;

-- COMMON TABLE EXPRESSION

-- create table "order"
CREATE TABLE Orders (
	Id INT AUTO_INCREMENT,
    LearnerId INT NOT NULL,
    OrderDate TIMESTAMP NOT NULL,
    OrderStatus VARCHAR(16) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (LearnerId) REFERENCES Learner(Id)
);

DESC Orders;

-- insert data into orders table 1,2,3,4,5,6,7,10
-- OrderStatus => "Pending", "Complete", "Closed"
DESC Orders;

SELECT * FROM learner;

INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (1, "2024-01-11", "Pending");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (2, "2024-03-15", "Pending");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (3, "2024-02-26", "Complete");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (4, "2024-06-02", "Complete");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (5, "2024-01-29", "Closed");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (6, "2024-04-18", "Closed");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (7, "2024-01-21", "Pending");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (10, "2024-04-01", "Complete");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (4, "2024-06-02", "Pending");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (5, "2024-01-29", "Complete");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (6, "2024-04-18", "Pending");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (7, "2024-01-21", "Closed");
INSERT INTO Orders (LearnerId, OrderDate, OrderStatus) VALUES (10, "2024-04-01", "Closed");

SELECT * FROM Orders;

-- total order per student
SELECT * FROM Orders;

SELECT LearnerId, COUNT(Id) AS TotalOrder FROM Orders
GROUP BY LearnerId;

-- total order per student and display learner FirstName and LastName also
SELECT * FROM Orders;

SELECT * FROM Learner;

SELECT l.Id, l.FirstName, l.LastName, t.TotalOrder FROM Learner AS l
JOIN 
(SELECT LearnerId, COUNT(Id) AS TotalOrder FROM Orders
GROUP BY LearnerId) AS t
	ON l.Id = t.LearnerId;

-- total order per student and display learner FirstName and LastName and at last add average orders for all learners	
SELECT l.Id, l.FirstName, l.LastName, t.TotalOrder, AVG(t.TotalOrder) OVER() AS AvgOrders FROM Learner AS l
JOIN 
(SELECT LearnerId, COUNT(Id) AS TotalOrder FROM Orders
GROUP BY LearnerId) AS t
	ON l.Id = t.LearnerId;
    
SELECT l.Id, l.FirstName, l.LastName, t.TotalOrder, AVG(SUM(t.TotalOrder)) OVER() AS AvgOrders FROM Learner AS l
JOIN 
(SELECT LearnerId, COUNT(Id) AS TotalOrder FROM Orders
GROUP BY LearnerId) AS t
	ON l.Id = t.LearnerId
GROUP BY t.LearnerId;
    
    
    
    
    
    
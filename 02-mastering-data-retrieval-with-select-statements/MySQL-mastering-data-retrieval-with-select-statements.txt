-- difference between DELETE and DROP 
-- DELETE is a DML command => used to delete any record
-- DROP is a DDL command => used to delete complete table or database

USE mysqllearning;

-- create a table named Course (Id, Title, Duration_Months, Price)
CREATE TABLE Course (
	Id INT AUTO_INCREMENT,
    Title VARCHAR(48) NOT NULL,
    Duration_Months INT NOT NULL,
    Price INT NOT NULL,
    PRIMARY KEY (Id)
);

DESC course;

-- insert data in Course table
INSERT INTO Course (Title, Duration_Months, Price) VALUES ('The Complete Javascript Mastery', 3, 899);
INSERT INTO Course (Title, Duration_Months, Price) VALUES ('The Complete React Mastery', 4, 1299);
INSERT INTO Course (Title, Duration_Months, Price) VALUES ('The Complete Nodejs Mastery', 6, 2999);

SELECT * FROM Course;

-- difference between PRIMARY KEY and UNIQUE KEY
-- PRIMARY KEY => UNIQUE and NOT NULL
-- UNIQUE KEY => UNIQUE and can be null

-- create a table Learner 
-- (Id, FirstName, LastName, Email, PhoneNumber, EnrollmentDate, SelectedCourse, Experience, Company, SourceOfJoining, BatchDate, Location)
CREATE TABLE Learner (
	Id INT AUTO_INCREMENT,
    FirstName VARCHAR(48) NOT NULL,
    LastName VARCHAR(48) NOT NULL,
    Email VARCHAR(48) NOT NULL,
    PhoneNumber VARCHAR(16),
    EnrollmentDate TIMESTAMP NOT NULL,
    SelectedCourse INT NOT NULL,
    Experience INT NOT NULL, 
    Company VARCHAR(48), 
    SourceOfJoining VARCHAR(24) NOT NULL,
    BatchStartDate TIMESTAMP NOT NULL,
    Location VARCHAR(48) NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE KEY (PhoneNumber),
    FOREIGN KEY (SelectedCourse) REFERENCES Course(Id) -- provided value for SelectedCourse should be a part of Id in Course table
);

DESC Learner;

-- insert data into Learner table
-- timestamp format => 'yyyy-mm-dd'
-- DateOfEnrollment < BatchStartDate for SelectedCourse
INSERT INTO Learner(FirstName, LastName, Email, PhoneNumber, EnrollmentDate, SelectedCourse, Experience, Company, SourceOfJoining, BatchStartDate, Location)
VALUES ('Kaaleen', 'Bhaiya', 'katte@mirzapur.com', '1111111111', '2024-05-01', 1, 4, 'Amazon', 'LinkedIn', '2024-07-21', 'Jaunpur');
INSERT INTO Learner(FirstName, LastName, Email, PhoneNumber, EnrollmentDate, SelectedCourse, Experience, Company, SourceOfJoining, BatchStartDate, Location)
VALUES ('Bina', 'Tripathi', 'bina@tripathi.com', '2222222222', '2024-05-01', 1, 4, 'Amazon', 'TikTok', '2024-07-21', 'Mirzapur');
INSERT INTO Learner(FirstName, LastName, Email, PhoneNumber, EnrollmentDate, SelectedCourse, Experience, Company, SourceOfJoining, BatchStartDate, Location)
VALUES ('Munna', 'Tripathi', 'ias@padhaikaro.com', '3333333333', '2024-05-10', 2, 2, 'Flipkart', 'Twitter', '2024-07-21', 'Meerut');
INSERT INTO Learner(FirstName, LastName, Email, PhoneNumber, EnrollmentDate, SelectedCourse, Experience, Company, SourceOfJoining, BatchStartDate, Location)
VALUES ('Guddu', 'Bhaiya', 'bahubali@mirzapur.com', '4444444444', '2024-06-15', 3, 3, 'Apple', 'Facebook', '2024-07-21', 'Ghaziabad');
INSERT INTO Learner(FirstName, LastName, Email, PhoneNumber, EnrollmentDate, SelectedCourse, Experience, Company, SourceOfJoining, BatchStartDate, Location)
VALUES ('Lala', 'Kareem', 'afeem@network.com', '5555555555', '2024-01-01', 2, 10, 'Facebook', 'Facebook', '2024-07-21', 'Gujrat');
INSERT INTO Learner(FirstName, LastName, Email, PhoneNumber, EnrollmentDate, SelectedCourse, Experience, Company, SourceOfJoining, BatchStartDate, Location)
VALUES ('Sharad', 'Shukla', 'wannabe@mirzapur.com', '6666666666', '2024-02-27', 1, 4, 'Amazon', 'LinkedIn', '2024-07-21', 'Mumbai');
INSERT INTO Learner(FirstName, LastName, Email, PhoneNumber, EnrollmentDate, SelectedCourse, Experience, Company, SourceOfJoining, BatchStartDate, Location)
VALUES ('JP', 'Yadav', 'mantri@cm.com', '7777777777', '2024-06-29', 1, 2, 'CoalIndia', 'TikTok', '2024-07-21', 'Rajsthan');
INSERT INTO Learner(FirstName, LastName, Email, PhoneNumber, EnrollmentDate, SelectedCourse, Experience, Company, SourceOfJoining, BatchStartDate, Location)
VALUES ('Makbool', 'Ansari', 'righthand@kaleen.com', null, '2024-04-29', 1, 2, 'SEBI', 'Whatsapp', '2024-07-21', 'Chambal');

SELECT * FROM Learner;

DELETE FROM Learner WHERE Id = 11;

-- data analysis (employee, course, learner)

-- record of employee getting highest salary (flow => FROM, SELECT, ORDER BY, LIMIT)
DESC Employee;

SELECT * FROM Employee 
ORDER BY Salary DESC 
LIMIT 1;

SELECT MAX(Salary) AS Max_Salary FROM Employee;
SELECT MIN(Salary) AS Min_Salary FROM Employee;

SELECT * FROM Employee
WHERE Salary = (
	SELECT MAX(Salary) FROM Employee
);

-- record of employee getting highest salary having age greater than 25
-- (flow => FROM, WHERE, SELECT, ORDER BY, LIMIT)
SELECT * FROM Employee;

SELECT * FROM Employee
WHERE Age > 25
ORDER BY Salary DESC
LIMIT 1;

-- display the total number of enrollment in courses
-- (flow => FROM, COUNT, SELECT)
SELECT COUNT(*) AS TotalEnrollment FROM Learner;

SELECT * FROM Learner;

-- display the total number of enrollment in course having Id 3
-- (flow => FROM, WHERE, COUNT, SELECT)
-- it is good to mention PRIMARY KEY in COUNT as it not count the duplicate and empty values
SELECT * FROM Learner;

SELECT COUNT(PhoneNumber) AS TotalEnrolled FROM Learner;

SELECT COUNT(Id) AS TotalEnrolled FROM Learner
WHERE SelectedCourse = 3;

-- count the number of learners enrolled in month of jan 2024
-- (flow => FROM, WHERE, COUNT, SELECT)
SELECT * FROM Learner;

SELECT COUNT(Id) AS EnrolledInJan2024 FROM Learner
WHERE EnrollmentDate > '2023-12-31' AND EnrollmentDate <'2024-02-01';

SELECT COUNT(Id) AS EnrolledInJan2024 FROM Learner
WHERE EnrollmentDate LIKE ('2024-01-%');

-- count of distinct companies learners belongs to
-- count will count NOT NULL entries
-- (flow => FROM, DISTINCT, COUNT, SELECT)
SELECT * FROM Learner;

SELECT COUNT(DISTINCT Company) AS DistinctCompanies FROM Learner;











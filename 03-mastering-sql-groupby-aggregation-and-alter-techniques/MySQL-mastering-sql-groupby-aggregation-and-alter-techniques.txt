SHOW DATABASES;
USE mysqllearning;
SHOW TABLES;

-- count of learners joined via different sources (LinkedIn, TikTok, Facebook, Twitter, Whatsapp)
SELECT * FROM learner;
-- (flow => FROM, SELECT, GROUP BY, COUNT)
SELECT SourceOfJoining, COUNT(Id) AS NoOfLearners FROM learner
GROUP BY SourceOfJoining;

SELECT * FROM learner;
-- grouping via SourceOfJoining and Location
-- on grouping, only column about which we are grouping, can be selected as non-aggragated
-- all other columns can be selected but only by using some aggregator function
SELECT * FROM learner;

SELECT SourceOfJoining, Location, COUNT(Id) AS NoOfLearner FROM learner
GROUP BY SourceOfJoining, Location;

-- corresponding to each course, how many learners have enrolled
SELECT * FROM learner;

SELECT SelectedCourse, COUNT(Id) AS NoOfLearenersEnrolled FROM learner
GROUP BY SelectedCourse;

-- corresponding to individual SourceOfJoining, give the maximum years of experience any person hold
SELECT * FROM learner;

SELECT SourceOfJoining, MAX(Experience) AS Max_Exp FROM learner
GROUP BY SourceOfJoining;


-- corresponding to individual SourceOfJoining, give the minimum years of experience any person hold
SELECT * FROM learner;

SELECT SourceOfJoining, MIN(Experience) AS Min_Exp FROM learner
GROUP BY SourceOfJoining;

-- corresponding to individual SourceOfJoining, give the average years of experience
SELECT * FROM learner;

SELECT SourceOfJoining, AVG(Experience) AS Avg_Exp FROM learner
GROUP BY SourceOfJoining;

-- corresponding to individual SourceOfJoining, give the summation of years of experience
SELECT * FROM learner;

SELECT SourceOfJoining, SUM(Experience) AS Sum_Exp FROM learner
GROUP BY SourceOfJoining;

-- SourceOfJoining by which more than 1 learner enrolled
SELECT * FROM learner;
-- after GROUP BY if filteration required, use HAVING clause (enables filtering aggregated data)
SELECT SourceOfJoining, COUNT(Id) AS learners_enrolled_via_source FROM learner
GROUP BY SourceOfJoining
HAVING learners_enrolled_via_source > 1;

-- count of students joined via LinkedIn
SELECT * FROM learner;

SELECT COUNT(Id) AS LearnerJoinedViaLinkedIn FROM learner
GROUP BY SourceOfJoining
HAVING SourceOfJoining = 'LinkedIn';

-- courses which not includes "Nodejs"
SELECT * FROM course;

SELECT * FROM course
WHERE Title NOT LIKE '%Nodejs%';

-- learners having Experience less than 4 years and SourceOfJoining is "TikTok" and Location is "Rajasthan"
SELECT * FROM learner;

SELECT * FROM learner
WHERE Experience < 4 AND SourceOfJoining = 'TikTok' AND Location = 'Rajasthan';

-- learners having Experience between 1 to 3 years
SELECT * FROM learner;

SELECT * FROM learner
WHERE Experience BETWEEN 1 AND 3;

-- learners having Experience less than 4 years or SourceOfJoining is "TikTok" or Location is "Rajasthan"
SELECT * FROM learner;

SELECT * FROM learner
WHERE Experience < 4 OR SourceOfJoining = 'TikTok' OR Location = 'Rajasthan';

-- add one column to employee table naming jobPosition
DESC employee;
ALTER TABLE employee ADD COLUMN jobPosition varchar(32);
DESC employee;

-- modify FirstName type to varchar(24)
DESC employee;
ALTER TABLE employee MODIFY COLUMN FirstName varchar(24);
DESC employee;

-- delete column jobPosition from employee table
DESC employee;
ALTER TABLE employee DROP COLUMN jobPosition;
DESC employee;

-- TRUNCATE command
-- difference between DELETE and TRUNCATE command
-- DELETE is a DML command and TRUNCATE is a DDL command
-- DELETE will delete the record/s depending on the WHERE clause
-- TRUNCATE will delete all the records and there is no WHERE clause

-- DECIMAL datatype 
-- implicit type conversion happened as Duration_Months data type is INT and provided value is 5.5
SELECT * FROM Course;
INSERT INTO Course (Title, Duration_Months, Price) VALUES ('The Complete AI/ML', 5.5, 7999);
SELECT * FROM Course;

CREATE TABLE Course_Update(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(48) NOT NULL,
    Duration_Months DECIMAL(3, 1) NOT NULL,
    Price INT NOT NULL
);

INSERT INTO Course_Update (Title, Duration_Months, Price) VALUES ('The Complete Javascript Mastery', 3.5, 899);
INSERT INTO Course_Update (Title, Duration_Months, Price) VALUES ('The Complete React Mastery', 4.47, 1299);
INSERT INTO Course_Update (Title, Duration_Months, Price) VALUES ('The Complete Nodejs Mastery', 77.38, 2999);
INSERT INTO Course_Update (Title, Duration_Months, Price) VALUES ('The Complete AI/ML', 5.5, 7999);

SELECT * FROM Course_Update;

-- add column in Course_Update table to store the time of creation of a new record
SELECT * FROM Course_Update;
ALTER TABLE Course_Update ADD COLUMN Created_At TIMESTAMP DEFAULT NOW();
ALTER TABLE Course_Update ADD COLUMN Updated_At TIMESTAMP DEFAULT NOW();
SELECT * FROM Course_Update;
INSERT INTO Course_Update (Title, Duration_Months, Price) VALUES ('The Complete Data Science', 11.5, 12999);
SELECT * FROM Course_Update;

-- add column in Course_Update table to store the time of update made to any existing record
SELECT * FROM Course_Update;
ALTER TABLE Course_Update MODIFY COLUMN Updated_At TIMESTAMP ON UPDATE NOW();
SELECT * FROM Course_Update;
UPDATE Course_Update SET Price = 11999 WHERE Id = 5;
SELECT * FROM Course_Update;



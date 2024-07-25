-- https://leetcode.com/problems/employees-earning-more-than-their-managers/description/

SELECT e.name AS Employee 
FROM Employee AS e
JOIN Employee AS m
ON e.managerId = m.id
WHERE e.salary > m.salary;

-- data analysis questions

-- 1. Which courses have the highest enrollment rates?
-- course id, course name and enrollment count
SELECT * FROM learner;
SELECT * FROM course;
SELECT c.Id, c.Title, COUNT(l.Id) AS enrollment_count FROM learner AS l
JOIN course AS c
ON l.SelectedCouRse = c.Id
GROUP BY c.Id, c.Title
ORDER BY enrollment_count DESC
LIMIT 1;

-- more optimized as first filtering done then doing join operation
SELECT Id, Title, temptable.Enrolled_Learners FROM Course
JOIN
(SELECT SelectedCourse, COUNT(Id) AS Enrolled_Learners FROM Learner
GROUP BY SelectedCourse
ORDER BY Enrolled_Learners DESC
LIMIT 1) AS temptable
ON Course.Id = temptable.SelectedCourse;






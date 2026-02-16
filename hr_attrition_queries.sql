CREATE DATABASE hr_attrition;
USE hr_attrition;
RENAME TABLE hr_employee_attrition TO employee;

SELECT* FROM Employee;

ALTER TABLE employee
RENAME COLUMN `ï»¿Age` TO Age;

#How Many Employee are in the dataset
SELECT COUNT(*) AS TotalEmployees
From Employee;

#How many employees left vs stayed?
SELECT Attrition, COUNT(*) AS Total
from Employee
Group by Attrition;

#What is the overall attrition rate?
SELECT ROUND(COUNT(CASE WHEN Attrition = "Yes" THEN 1 END)* 100.0/ COUNT(*), 2) AS AttritionRate
FROM Employee;

#How many employees left from each department?
SELECT Department, COUNT(*) EmployeesLeft
From Employee
WHERE Attrition = "Yes"
Group by Department
Order by EmployeesLeft;


#What is the attrition rate per department?
SELECT Department,
COUNT(*) AS TotalEmployees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS TotalLeft,
ROUND(AVG(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END)*100,2) AS AttritionRate
FROM employee
GROUP BY Department
ORDER BY AttritionRate DESC;

#Which job roles have highest attrition?
SELECT JobRole,
COUNT(*) AS TotalEmployees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS TotalLeft,
ROUND(AVG(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END)*100,2) AS AttritionRate
FROM employee
GROUP BY JobRole
ORDER BY AttritionRate DESC;

#What is average salary of employees who left vs stayed?
SELECT Attrition,
ROUND(AVG(MonthlyIncome),2) AS AvgSalary
FROM Employee
group by Attrition;

#Do overtime employees leave more?
SELECT Overtime, Attrition, COUNT(*) AS Total
FROM Employee
GROUP BY Overtime, Attrition 
order by OverTime;

#What is average satisfaction score for employees who left?
SELECT Attrition, 
ROUND(AVG(JobSatisfaction),2) AS AvgSatisfatction, 
ROUND(AVG(EnvironmentSatisfaction),2) AS AvgEnvSatisfaction,
ROUND(AVG(WorkLifeBalance),2) AS AvgWorkLifeBalance
FROM Employee
Group BY Attrition;

# Attrition rate by age group:

SET sql_mode = '';
SELECT 
CASE 
    WHEN Age < 30 THEN 'Under 30'
    WHEN Age < 40 THEN '30-39'
    WHEN Age < 50 THEN '40-49'
    ELSE '50+'
END AS AgeGroup,
COUNT(*) AS TotalEmployees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS TotalLeft,
ROUND(AVG(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END)*100,2) AS AttritionRate
FROM employee
GROUP BY AgeGroup
ORDER BY AttritionRate DESC;

#Find employees most at risk:
SELECT EmployeeNumber,Age, JobRole, Department, JobSatisfaction,OverTime,MonthlyIncome
FROM Employee
WHERE Attrition = "No"
AND JobSatisfaction <=2
AND OverTime ="Yes"
AND MonthlyIncome < 5000
ORDER BY Attrition ASC, MonthlyIncome ASC;


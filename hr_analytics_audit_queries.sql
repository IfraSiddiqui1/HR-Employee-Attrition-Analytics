
CREATE DATABASE IF NOT EXISTS hr_analytics_db;


USE hr_analytics_db;
CREATE TABLE IF NOT EXISTS employee_attrition (
    EmployeeID VARCHAR(20) PRIMARY KEY,
    Age INT,
    Attrition VARCHAR(10),
    Department VARCHAR(50),
    JobRole VARCHAR(50),
    MonthlyIncome INT,
    Gender VARCHAR(20),
    MaritalStatus VARCHAR(20),
    EducationField VARCHAR(50),
    OverTime VARCHAR(10),
    YearsAtCompany INT,
    JobSatisfaction INT,
    WorkLifeBalance INT,
    PerformanceRating INT
);
SELECT * FROM hr_employee_attrition_data LIMIT 10;
select Overtime, count(*)
FROM hr_employee_attrition_data 
group by Overtime

SELECT Department, attrition, Count(*) As Total_Employees
from hr_employee_attrition_data
Group by Department, attrition
Order by Department, attrition DESC;

-- ========================================================
-- Project: HR Analytics & Employee Attrition Audit
-- Task: Calculate Average Monthly Income Grouped by Department
-- Purpose: To analyze salary distribution across different departments
-- ========================================================

SELECT 
    Department, 
    COUNT(*) AS Total_Employees,
    ROUND(AVG(MonthlyIncome), 2) AS Average_Monthly_Income
FROM 
    hr_employee_attrition_data
GROUP BY 
    Department
ORDER BY 
    Average_Monthly_Income DESC;
    
    
-- ========================================================
-- Task: High-Risk Employee Analysis (Low Satisfaction & Overtime)
-- Purpose: Identify employees with Low Job Satisfaction (1) working Overtime
-- ========================================================


Select
   Department,
   JobRole,
   Attrition,
   MonthlyIncome,
   YearsatCompany
From   
  hr_employee_attrition_data
Where
  JobSatisfaction = 1
  And OverTime = 'Yes'
order by
  MonthlyIncome ASC;  


-- ========================================================
-- Task: Job Role Attrition & Average Income Audit
-- Purpose: Calculate total count, attrition count, attrition rate %, 
--          and average monthly income grouped by Job Role.
-- ========================================================


select
   JobRole,
   count(*) As Total_Employees,
   Sum(case when Attrition = 'Yes' Then 1 Else 0 End) As Attrition_Count,
   round((Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) *100.0)/Count(*),2) As Attrition_Rate_Pct,
   round(avg(MonthlyIncome),2) As Avg_Monthly_Income 
From
   hr_employee_attrition_data 
Group by
   JobRole 
order by
   Attrition_Rate_Pct desc;    
   
   
-- ========================================================
-- Task: Department-Level Executive Summary Audit
-- Purpose: Calculate Total Count, Avg Age, Avg Income, 
--          and Avg Tenure grouped by Department.
-- ========================================================

select
   Department,
   count(*) As Total_Employees,
   round(Avg (Age),1) As Avg_Age,
   round(Avg (MonthlyIncome),2) As Avg_Montly_Income,
   round(Avg(YearsAtCompany),1) As Avg_Tenure_Years
From   
   hr_employee_attrition_data 
group by
   Department
order by
   Total_Employees desc;
   
   
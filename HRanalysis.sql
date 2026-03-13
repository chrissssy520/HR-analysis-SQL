-- ============================================
-- HR Employee Data Analysis
-- Author: Christian Kho Aler
-- Note: Raw dataset backed up as hr_employee_dataset_backup.csv
--       before any data modification was applied
-- ============================================



-- Largest Average Salary by Department and Position

SELECT DISTINCT department, position,  

ROUND(AVG(salary)
OVER(PARTITION BY department),2) AS avg_salary
    FROM Hrdata
    ORDER BY avg_salary DESC;

-- Employees whose salary are higher than Average salary

SELECT employee_id, full_name, salary,

(SELECT ROUND(AVG(salary),2) FROM hrdata)  as company_avg,

salary - ( SELECT ROUND(AVG(salary),2) FROM hrdata) as salary_gap

FROM hrdata
WHERE salary > (SELECT AVG(salary) FROM hrdata)
ORDER BY salary DESC;

-- Total Number of Employee per Department

SELECT DISTINCT department,
	COUNT(*)
	OVER(PARTITION BY department) AS total_employee
    FROM Hrdata
    ORDER BY total_employee DESC;
    
-- Total Number of Employee per Position

SELECT DISTINCT position,
	COUNT(*)
	OVER(PARTITION BY position) AS total_employee
    FROM Hrdata
    ORDER BY total_employee DESC;
    
-- Rank 5 of Employees with Most Absences

WITH rank_absent AS (
SELECT DISTINCT Employee_id, Full_name, SUM(Absences) as total_absent,
		DENSE_RANK() OVER(ORDER BY SUM(Absences) DESC ) AS rnk
        FROM hrdata
        GROUP BY full_name, employee_id
        )
 
SELECT 
	Employee_id,
    full_name,
    total_absent,
    rnk
    FROM rank_absent
    WHERE rnk <= 5;
    
-- Gender comparison and Average age
SELECT Gender, COUNT(*) as head_count,
	ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() ,2) AS head_percentage, 
    ROUND(AVG(Age),2) as avg_age 
FROM hrdata
GROUP BY gender;

-- Longest Tenured

WITH rank_years as (
SELECT 
	Employee_id,
	Full_name, 
  MAX(years_at_Company) as max_years,
   DENSE_RANK() OVER(ORDER BY MAX(years_at_Company) DESC) as rnk
    FROM hrdata
    GROUP BY full_name, Employee_id
)

SELECT * FROM rank_years
	WHERE rnk = 1;
    

-- List of employees that have Low satisfaction rate
SELECT
 employee_id, 
 full_name, 
 Job_satisfaction
 FROM hrdata
 WHERE job_satisfaction < 3
 ORDER BY job_satisfaction;



-- Fix Inconsistent data / Job_satisfaction and Performance_rating is not align

SELECT 
	employee_id,
    full_name,
    Job_satisfaction,
    Performance_rating,
    CASE WHEN Job_satisfaction >= 4 THEN "Outstanding"
		 WHEN Job_satisfaction >= 3 THEN "Meets Expectations"
         ELSE "Disappointed" END AS suggested_rate
         FROM hrdata
         ORDER BY job_satisfaction;
         
SET SQL_SAFE_UPDATES = 0;

UPDATE hrdata
		 SET Performance_rating = 
	     CASE WHEN Job_satisfaction >= 4 THEN "Outstanding"
		 WHEN Job_satisfaction >= 3 THEN "Meets Expectations"
         ELSE "Disappointed" END;
    
SET SQL_SAFE_UPDATES = 1;


-- List of employees who are no longer active (Resigned or Terminated)

SELECT * FROM hrdata 
WHERE employment_status IN ("Terminated","Resigned");

-- Employee Distribution per Region

SELECT region, COUNT(*) as total_region FROM hrdata
GROUP BY region
ORDER BY total_region DESC;

-- Employees who received the most promotions


WITH rank_promotion as (
SELECT 
	employee_id,
    full_name,
	SUM(promotions) as total_promotion,
    DENSE_RANK() OVER(ORDER BY SUM(promotions) DESC) as rnk
     
    FROM hrdata
	GROUP BY employee_id, full_name

)

SELECT 
	employee_id,
    full_name,
    total_promotion,
    rnk
    FROM rank_promotion
    WHERE rnk = 1;
    
-- Promotion rate per Department
    
SELECT 
	department,
    COUNT(*) as total_employee,
    SUM(promotions) as total_promotion,
    ROUND(SUM(promotions) / COUNT(*) * 100 ,2) AS promotion_rate_percentage
    FROM hrdata
    GROUP BY department
    ORDER BY promotion_rate_percentage DESC;
    
    
    
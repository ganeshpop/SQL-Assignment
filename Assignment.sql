/*1.
The HR department needs a query that prompts the user for an employee last name. The query then displays the last name and hire 
date of any employee in the same department as the employee whose name they supply (excluding that employee). For example, if the user enters Zlotkey, 
find all employees who work with Zlotkey (excluding Zlotkey).*/

SELECT e.last_name  , e.hire_date FROM employees e
	WHERE department_id = (SELECT department_id FROM employees WHERE last_name LIKE '%Austin%');
    
/*2.
Create a report that displays the employee number,  last name, and salary of all employees who earn more than the average salary. 
Sort the results in order of ascending salary.*/

SELECT employee_id, last_name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees) ORDER BY salary ASC;

/*3.Write a query that displays the employee number and last name of all employees who work 
	in a department with any employee whose last name contains a u.*/

SELECT employee_id, last_name, department_id 
	FROM employees 
	WHERE department_id IN (SELECT department_id FROM employees WHERE last_name REGEXP 'u');
    
/*4.
The HR department needs a report that displays the last name, department number,
 and job ID of all employees whose department location ID is 1700.*/

SELECT last_name, e.department_id, e.job_id FROM employees e, departments d 
	WHERE e.department_id = d.department_id AND d.location_id = 1700;
    
/*5.
Create a report for HR that displays the last name and salary of every employee who reports to King.*/

SELECT last_name, salary FROM employees 
	WHERE manager_id = (SELECT employee_id FROM employees WHERE last_name LIKE '%King%');
    
/*6.
Create a report for HR that displays the department number, last name, and job ID for every employee in the Executive department.*/

SELECT e.department_id, e.last_name, e.job_id FROM employees e 
	WHERE department_id = (SELECT department_id FROM departments d WHERE d.department_name like '%Executive%');
    
/*7.
Write a query for the HR department to produce the addresses of all the departments. Use the LOCATIONS and COUNTRIES tables. 
Show the location ID, street address, city, state or province, and country in the output. Use a NATURAL JOIN to produce the results.*/

SELECT location_id, street_address, city, state_province, r.country_name FROM locations NATURAL JOIN countries r;

/*8.
ALTERThe HR department needs a report of all employees.
 Write a query to display the last name, department number, and department name for all employees.*/
 
  -- SELECT e.last_name, e.department_id, d.department_name FROM employees e JOIN departments d ON e.department_id = d.department_id;
  SELECT e.last_name, e.department_id, d.department_name FROM employees e JOIN departments d USING (department_id);
  
/*9.
The HR department needs a report of employees in Toronto. 
Display the last name, job, department number, and department name for all employees who work in Toronto.*/

SELECT e.last_name, e.department_id, d.department_name 
	FROM employees e
    JOIN departments d USING (department_id)
    WHERE e.department_id IN (SELECT department_id from departments WHERE location_id = ( SELECT location_id FROM locations WHERE city REGEXP 'Toronto' ));
    
/*10.
 Create a report to display employees’ last name and 
 employee number along with their manager’s last name and manager number.
 Label the columns Employee, Emp#, Manager, and Mgr#, respectively.*/
 
 SELECT e.last_name AS 'Employee', e.employee_id AS 'Emp#', m.last_name AS 'Manager', m.employee_id AS 'Mgr#' 
		FROM employees e 
			JOIN employees m ON e.manager_id = m.employee_id;
/* 11.
Display all employees including King, who has no manager. Order the results by the employee number.*/

SELECT e.last_name AS 'Employee', e.employee_id AS 'Emp#', m.last_name AS 'Manager', m.employee_id AS 'Mgr#' 
		FROM employees e 
			LEFT JOIN employees m ON e.manager_id = m.employee_id;
            
/*12.
Create a report for the HR department that displays employee last names, department numbers,
 and all the employees who work in the same department as a given employee. 
 Give each column an appropriate label. */
 
 SELECT e.department_id AS Department, e.last_name AS Employee, c.last_name AS Colleague  
	FROM employees e, employees c 
    WHERE e.department_id = c.department_id AND e.employee_id <> c.employee_id
    ORDER BY e.last_name;
    
/*13.
The HR department needs a list of department IDs 
for departments that do not contain the job ID ST_CLERK. Use set operators to create this report.*/

SELECT department_id FROM departments 
	WHERE department_id NOT IN (SELECT DISTINCT department_id FROM employees WHERE job_id REGEXP 'IT_PROG');
    
/*14.
The HR department needs a list of countries that have no departments located in them. 
Display the country ID and the name of the countries. Use set operators to create this report.*/

SELECT country_id, country_name 
	FROM countries
    WHERE country_id NOT IN (SELECT country_id FROM locations WHERE location_id IN (SELECT Location_id FROM departments));
    
/*15.
Produce a list of jobs for departments 10, 50, and 20, in that order. 
Display job ID and department ID using set operators.*/

SELECT job_id AS JobID FROM employees WHERE department_id IN (10, 50, 20);

/*16.
Create a report that lists the employee IDs and job IDs of those employees who currently have a job title
that is the same as their job title when they were initially hired by the company 
(that is, they changed jobs but have now gone back to doing their original job).*/

SELECT employee_id, job_id
FROM employees WHERE employee_id IN (SELECT employee_id FROM job_history) AND job_id IN (SELECT job_id FROM job_history); 

/*17.
 Find the highest, lowest, sum, and average salary of all employees. Label the columns
 Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest number. */
 
 SELECT MAX(salary) AS Maximum, MIN(salary) AS Mimimum, SUM(salary) AS Sum, round(AVG(salary),2) AS Average From employees;
  
 /*18.
 Write a query to display the number of people with the same job.*/
 
 SELECT e.job_id, COUNT(*) AS 'Employees Count'
  FROM Employees e
  GROUP BY e.department_id;
 
 /*19.
 Determine the number of managers without listing them. Label the column Number of Managers. 
 Hint: Use the MANAGER_ID column to determine the number of managers*/
 
 SELECT COUNT(DISTINCT manager_id) "Number of Managers"
	FROM employees;
    
/*20.
Find the difference between the highest and lowest salaries. Label the column DIFFERENCE.*/

SELECT (MAX(salary) - MIN(salary)) AS Difference FROM employees;

# SQL Case Study 2: Human Resources by Data In Motion, LLC

## Link to the in browser SQL: https://www.db-fiddle.com/f/xckGL9ZW73A6FWhsmPogm7/6

### Create 'departments' table
    CREATE TABLE departments (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50),
        manager_id INT
    );
    
### Create 'employees' table
    CREATE TABLE employees (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50),
        hire_date DATE,
        job_title VARCHAR(50),
        department_id INT REFERENCES departments(id)
    );
    
### Create 'projects' table
    CREATE TABLE projects (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50),
        start_date DATE,
        end_date DATE,
        department_id INT REFERENCES departments(id)
    );
    
### Insert data into 'departments'
    INSERT INTO departments (name, manager_id)
    VALUES ('HR', 1), ('IT', 2), ('Sales', 3);
    
### Insert data into 'employees'
    INSERT INTO employees (name, hire_date, job_title, department_id)
    VALUES ('John Doe', '2018-06-20', 'HR Manager', 1),
           ('Jane Smith', '2019-07-15', 'IT Manager', 2),
           ('Alice Johnson', '2020-01-10', 'Sales Manager', 3),
           ('Bob Miller', '2021-04-30', 'HR Associate', 1),
           ('Charlie Brown', '2022-10-01', 'IT Associate', 2),
           ('Dave Davis', '2023-03-15', 'Sales Associate', 3);
    
### Insert data into 'projects'
    INSERT INTO projects (name, start_date, end_date, department_id)
    VALUES ('HR Project 1', '2023-01-01', '2023-06-30', 1),
           ('IT Project 1', '2023-02-01', '2023-07-31', 2),
           ('Sales Project 1', '2023-03-01', '2023-08-31', 3);
           
           UPDATE departments
    SET manager_id = (SELECT id FROM employees WHERE name = 'John Doe')
    WHERE name = 'HR';
    
    UPDATE departments
    SET manager_id = (SELECT id FROM employees WHERE name = 'Jane Smith')
    WHERE name = 'IT';
    
    UPDATE departments
    SET manager_id = (SELECT id FROM employees WHERE name = 'Alice Johnson')
    WHERE name = 'Sales';

## SQL Challenge Questions

### 1. Find the longest ongoing project for each department.
Select id,
	Name,
	Start_date,
	End_date,department_id,
	Max(end_date - Start_date) as Project_Period
From projects
Group by id
Order by Project_Period Desc
![Q1](https://github.com/Ofochinedu/Portfolio-Projects/assets/127870290/b37c3e17-2206-4127-b98e-6fe850b80343)


### 2. Find all employees who are not managers.
Select id,
	Name,
	Job_Title
From Employees
Where job_title not like '%Manager%'
![Q2](https://github.com/Ofochinedu/Portfolio-Projects/assets/127870290/561cd6bd-dbd9-4251-9a96-ebbafd7dff91)

### 3. Find all employees who have been hired after the start of a project in their department.
Select p.department_id,
	e.name,
    e.job_title,
    e.hire_date,
    p.start_date project_start_date,
    p.name project_name
From Projects p
	Join employees e
	on p.department_id = e.department_id
Where start_date <= Hire_date
![Q3](https://github.com/Ofochinedu/Portfolio-Projects/assets/127870290/5bca8b14-3ebc-4d1a-a76c-696a73aee185)

### 4. Rank employees within each department based on their hire date (earliest hire gets the highest rank).
Select	D.name dept_name,
	E.name,
    E.hire_date,
    E.department_id,
    Rank()Over(Partition by D.name Order by hire_date)
From Employees E
	Join Departments D
	on E.department_id = D.id
![Q4](https://github.com/Ofochinedu/Portfolio-Projects/assets/127870290/51c084a4-6d78-4db3-a619-5a276bc6b207)


### 5. Find the duration between the hire date of each employee and the hire date of the next employee hired in the same department.
Select E1.department_id,D.name department_name,
	E2.name,E2.hire_date,
    E1.name new_hiree,E1.hire_date new_hire_date,
    Max(E1.hire_date) - Min(E2.hire_date) duration
From Employees E1
	Join Employees E2
	On E1.department_id = E2.department_id And E1.hire_date > E2.hire_date
	Join departments D
	On E1.department_id = D.id
Group by E1.department_id,E1.hire_date,E1.name,E2.hire_date,E2.name,D.name
Order by E1.department_id
![Q5](https://github.com/Ofochinedu/Portfolio-Projects/assets/127870290/021af23a-98f7-499e-9f1b-0731739458bc)

-- Departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

-- Jobs table
CREATE TABLE jobs (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    job_title VARCHAR(100) NOT NULL
);

-- Employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id INT,
    department_id INT,
    manager_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Salaries table
CREATE TABLE salaries (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    salary DECIMAL(10, 2),
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Departments
INSERT INTO departments (department_name)
VALUES ('HR'), ('Engineering'), ('Sales'), ('Marketing');

-- Jobs
INSERT INTO jobs (job_title)
VALUES ('HR Specialist'), ('Software Engineer'), ('Sales Representative'), ('Marketing Analyst');

-- Employees
INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_id, department_id, manager_id)
VALUES 
('Alice', 'Johnson', 'alice.j@example.com', '555-0100', '2022-01-10', 1, 1, NULL),
('Bob', 'Smith', 'bob.s@example.com', '555-0101', '2022-02-12', 2, 2, 1),
('Carol', 'Taylor', 'carol.t@example.com', '555-0102', '2022-03-15', 2, 2, 1),
('David', 'Lee', 'david.l@example.com', '555-0103', '2022-04-20', 3, 3, 1);

-- Salaries
INSERT INTO salaries (employee_id, salary, from_date, to_date)
VALUES
(1, 60000.00, '2022-01-10', NULL),
(2, 80000.00, '2022-02-12', NULL),
(3, 85000.00, '2022-03-15', NULL),
(4, 50000.00, '2022-04-20', NULL);

-- List of all employees & their departments:
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Average salary per department
SELECT d.department_name, AVG(s.salary) AS average_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
GROUP BY d.department_name;

-- Salaries above $75,000
SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.salary > 75000;

DELIMITER //

CREATE PROCEDURE AddEmployee(
    IN fname VARCHAR(50),
    IN lname VARCHAR(50),
    IN email VARCHAR(100),
    IN phone VARCHAR(20),
    IN hire DATE,
    IN job INT,
    IN dept INT,
    IN mgr INT
)
BEGIN
    INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_id, department_id, manager_id)
    VALUES (fname, lname, email, phone, hire, job, dept, mgr);
END //

DELIMITER ;

-- Add an employee via a stored procedure.
CALL AddEmployee('Eve', 'Martinez', 'eve.m@example.com', '555-0104', '2023-05-01', 1, 1, 1);

-- View for reporting
CREATE VIEW employee_summary AS
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name,
    j.job_title,
    s.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
JOIN salaries s ON e.employee_id = s.employee_id;

SELECT * FROM employee_summary;

-- Average salary by department.
SELECT d.department_name, AVG(s.salary) AS average_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
GROUP BY d.department_name;

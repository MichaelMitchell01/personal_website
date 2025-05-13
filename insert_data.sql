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

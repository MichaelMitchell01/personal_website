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
    INSERT INTO employees (
        first_name, last_name, email, phone_number, hire_date, job_id, department_id, manager_id
    )
    VALUES (fname, lname, email, phone, hire, job, dept, mgr);
END //

DELIMITER ;
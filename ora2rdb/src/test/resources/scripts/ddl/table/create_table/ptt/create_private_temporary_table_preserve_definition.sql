CREATE PRIVATE TEMPORARY TABLE ora$temp_employees (
    employee_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department_id NUMBER
) ON COMMIT PRESERVE DEFINITION;
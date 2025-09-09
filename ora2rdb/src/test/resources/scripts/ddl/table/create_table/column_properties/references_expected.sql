CREATE TABLE departments (
    department_id NUMERIC(34, 8) PRIMARY KEY
);

CREATE TABLE employees (
    employee_id NUMERIC(34, 8) PRIMARY KEY,
    department_id NUMERIC(34, 8) REFERENCES departments(department_id)
);
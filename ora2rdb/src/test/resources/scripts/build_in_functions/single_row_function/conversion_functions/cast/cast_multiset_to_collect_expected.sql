CREATE TABLE projects 
  (employee_id NUMERIC(34, 8), project_name VARCHAR(10));

CREATE TABLE emps_short 
  (employee_id NUMERIC(34, 8), last_name VARCHAR(10));

/*
[-unconvertible CREATE TYPE project_table_typ AS TABLE OF VARCHAR2(10);]
*/
/*
SELECT e.last_name,
       [-unconvertible CAST(MULTISET(SELECT p.project_name
                       FROM projects p 
                       WHERE p.employee_id = e.employee_id
                       ORDER BY p.project_name)
       AS project_table_typ)]
  FROM emps_short e
  ORDER BY e.last_name;
*/
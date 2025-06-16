CREATE TABLE projects 
  (employee_id NUMBER, project_name VARCHAR2(10));

CREATE TABLE emps_short 
  (employee_id NUMBER, last_name VARCHAR2(10));

CREATE TYPE project_table_typ AS TABLE OF VARCHAR2(10);

SELECT e.last_name,
       CAST(MULTISET(SELECT p.project_name
                       FROM projects p 
                       WHERE p.employee_id = e.employee_id
                       ORDER BY p.project_name)
       AS project_table_typ)
  FROM emps_short e
  ORDER BY e.last_name;
CREATE TABLE projects 
  (employee_id NUMERIC(34, 8), project_name VARCHAR(10));

CREATE TABLE emps_short 
  (employee_id NUMERIC(34, 8), last_name VARCHAR(10));

/*[-unconvertible RS-239346 CREATE TYPE project_table_typ AS TABLE OF VARCHAR(10);]*/

/*SELECT e.last_name,
       [-unconvertible RS-245838 CAST(MULTISET(SELECT p.project_name
                       FROM projects p 
                       WHERE p.employee_id = e.employee_id
                       ORDER BY p.project_name ASC NULLS LAST)
       AS project_table_typ)]
  FROM emps_short e
  ORDER BY e.last_name ASC NULLS LAST;*/
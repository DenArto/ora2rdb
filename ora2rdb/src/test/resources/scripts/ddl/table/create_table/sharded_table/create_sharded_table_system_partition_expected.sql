/*Found error(s) in file while parsing
Error at line 8:21 - no viable alternative at input 'emp_id'
*/



/*
Error at line 8:21 - no viable alternative at input 'emp_id'
-- RS-243163
CREATE SHARDED TABLE employees (
    emp_id NUMBER NOT NULL,
    name VARCHAR2(50),
    department VARCHAR2(50),
    salary NUMBER
)
PARTITION BY SYSTEM (emp_id)
PARTITIONS AUTO
TABLESPACE SET ts5;
*/
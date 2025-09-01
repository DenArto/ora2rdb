/*Found error(s) in file while parsing
Error at line 6:5 - no viable alternative at input 'CREATE TABLE departments_courses_hash (\n             department_id NUMBER(4) NOT NULL,\n             department_name VARCHAR2(30),\n             course_id NUMBER(4) NOT NULL)\n     PARTITION BY HASH(department_id)\n     SUBPARTITION'
*/

-- RS-243163

/*
Error at line 6:5 - no viable alternative at input 'CREATE TABLE departments_courses_hash (\n             department_id NUMBER(4) NOT NULL,\n             department_name VARCHAR2(30),\n             course_id NUMBER(4) NOT NULL)\n     PARTITION BY HASH(department_id)\n     SUBPARTITION'
CREATE TABLE departments_courses_hash (
             department_id NUMBER(4) NOT NULL,
             department_name VARCHAR2(30),
             course_id NUMBER(4) NOT NULL)
     PARTITION BY HASH(department_id)
     SUBPARTITION BY HASH (course_id) SUBPARTITIONS 32 PARTITIONS 16;
*/
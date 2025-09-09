-- RS-243163
CREATE TABLE departments_courses_hash (
             department_id NUMBER(4) NOT NULL,
             department_name VARCHAR2(30),
             course_id NUMBER(4) NOT NULL)
     PARTITION BY HASH(department_id)
     SUBPARTITION BY HASH (course_id) SUBPARTITIONS 32 PARTITIONS 16;
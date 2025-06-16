--------------------------------------------------------
--  File created - четверг-мая-15-2025
--------------------------------------------------------

--------------------------------------------------------
--  DDL for Sequence DEPARTMENTS_SEQ
--------------------------------------------------------

CREATE SEQUENCE  "HR"."DEPARTMENTS_SEQ"  MINVALUE 1 MAXVALUE 9990 INCREMENT BY 10 START WITH 280 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence EMPLOYEES_SEQ
--------------------------------------------------------

CREATE SEQUENCE  "HR"."EMPLOYEES_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 210 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence LOCATIONS_SEQ
--------------------------------------------------------

CREATE SEQUENCE  "HR"."LOCATIONS_SEQ"  MINVALUE 1 MAXVALUE 9900 INCREMENT BY 100 START WITH 3300 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence MYSQ
--------------------------------------------------------

CREATE SEQUENCE  "HR"."MYSQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  SCALE  EXTEND  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence SA_AIRCRAFT_ID
--------------------------------------------------------

CREATE SEQUENCE  "HR"."SA_AIRCRAFT_ID"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 76673 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Table COUNTRIES
--------------------------------------------------------

CREATE TABLE "HR"."COUNTRIES"
(	"COUNTRY_ID" CHAR(2 BYTE),
	"COUNTRY_NAME" VARCHAR2(40 BYTE),
	"REGION_ID" NUMBER,
	 CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") ENABLE
   ) ;
--------------------------------------------------------
--  DDL for Table DEPARTMENTS
--------------------------------------------------------

CREATE TABLE "HR"."DEPARTMENTS"
(	"DEPARTMENT_ID" NUMBER(4,0),
     "DEPARTMENT_NAME" VARCHAR2(30 BYTE),
     "MANAGER_ID" NUMBER(6,0),
     "LOCATION_ID" NUMBER(4,0)
);

--------------------------------------------------------
--  DDL for Table EMPLOYEES
--------------------------------------------------------

CREATE TABLE "HR"."EMPLOYEES"
(	"EMPLOYEE_ID" NUMBER(6,0),
     "FIRST_NAME" VARCHAR2(20 BYTE),
     "LAST_NAME" VARCHAR2(25 BYTE),
     "EMAIL" VARCHAR2(25 BYTE),
     "PHONE_NUMBER" VARCHAR2(20 BYTE),
     "HIRE_DATE" DATE,
     "JOB_ID" VARCHAR2(10 BYTE),
     "SALARY" NUMBER(8,2),
     "COMMISSION_PCT" NUMBER(2,2),
     "MANAGER_ID" NUMBER(6,0),
     "DEPARTMENT_ID" NUMBER(4,0)
);

--------------------------------------------------------
--  DDL for Table JOB_HISTORY
--------------------------------------------------------

CREATE TABLE "HR"."JOB_HISTORY"
(	"EMPLOYEE_ID" NUMBER(6,0),
     "START_DATE" DATE,
     "END_DATE" DATE,
     "JOB_ID" VARCHAR2(10 BYTE),
     "DEPARTMENT_ID" NUMBER(4,0)
);

--------------------------------------------------------
--  DDL for Table JOBS
--------------------------------------------------------

CREATE TABLE "HR"."JOBS"
(	"JOB_ID" VARCHAR2(10 BYTE),
     "JOB_TITLE" VARCHAR2(35 BYTE),
     "MIN_SALARY" NUMBER(6,0),
     "MAX_SALARY" NUMBER(6,0)
);

--------------------------------------------------------
--  DDL for Table LOCATIONS
--------------------------------------------------------

CREATE TABLE "HR"."LOCATIONS"
(	"LOCATION_ID" NUMBER(4,0),
     "STREET_ADDRESS" VARCHAR2(40 BYTE),
     "POSTAL_CODE" VARCHAR2(12 BYTE),
     "CITY" VARCHAR2(30 BYTE),
     "STATE_PROVINCE" VARCHAR2(25 BYTE),
     "COUNTRY_ID" CHAR(2 BYTE)
    );

--------------------------------------------------------
--  DDL for Table REGIONS
--------------------------------------------------------

CREATE TABLE "HR"."REGIONS"
(	"REGION_ID" NUMBER,
     "REGION_NAME" VARCHAR2(25 BYTE)
);
--------------------------------------------------------
--  DDL for View EMP_DETAILS_VIEW
--------------------------------------------------------

CREATE OR REPLACE FORCE EDITIONABLE VIEW "HR"."EMP_DETAILS_VIEW" ("EMPLOYEE_ID", "JOB_ID", "MANAGER_ID", "DEPARTMENT_ID", "LOCATION_ID", "COUNTRY_ID", "FIRST_NAME", "LAST_NAME", "SALARY", "COMMISSION_PCT", "DEPARTMENT_NAME", "JOB_TITLE", "CITY", "STATE_PROVINCE", "COUNTRY_NAME", "REGION_NAME") AS
SELECT
    e.employee_id,
    e.job_id,
    e.manager_id,
    e.department_id,
    d.location_id,
    l.country_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.commission_pct,
    d.department_name,
    j.job_title,
    l.city,
    l.state_province,
    c.country_name,
    r.region_name
FROM
    employees e,
    departments d,
    jobs j,
    locations l,
    countries c,
    regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id
    WITH READ ONLY
;
--------------------------------------------------------
--  DDL for Index REG_ID_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "HR"."REG_ID_PK" ON "HR"."REGIONS" ("REGION_ID");
--------------------------------------------------------
--  DDL for Index COUNTRY_C_ID_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "HR"."COUNTRY_C_ID_PK" ON "HR"."COUNTRIES" ("COUNTRY_ID");
--------------------------------------------------------
--  DDL for Index LOC_ID_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "HR"."LOC_ID_PK" ON "HR"."LOCATIONS" ("LOCATION_ID");
--------------------------------------------------------
--  DDL for Index DEPT_ID_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "HR"."DEPT_ID_PK" ON "HR"."DEPARTMENTS" ("DEPARTMENT_ID");
--------------------------------------------------------
--  DDL for Index JOB_ID_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "HR"."JOB_ID_PK" ON "HR"."JOBS" ("JOB_ID");
--------------------------------------------------------
--  DDL for Index EMP_EMAIL_UK
--------------------------------------------------------

CREATE UNIQUE INDEX "HR"."EMP_EMAIL_UK" ON "HR"."EMPLOYEES" ("EMAIL");
--------------------------------------------------------
--  DDL for Index EMP_EMP_ID_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "HR"."EMP_EMP_ID_PK" ON "HR"."EMPLOYEES" ("EMPLOYEE_ID");
--------------------------------------------------------
--  DDL for Index JHIST_EMP_ID_ST_DATE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "HR"."JHIST_EMP_ID_ST_DATE_PK" ON "HR"."JOB_HISTORY" ("EMPLOYEE_ID", "START_DATE");
--------------------------------------------------------
--  DDL for Index JHIST_EMPLOYEE_IX
--------------------------------------------------------

CREATE INDEX "HR"."JHIST_EMPLOYEE_IX" ON "HR"."JOB_HISTORY" ("EMPLOYEE_ID");
--------------------------------------------------------
--  DDL for Index LOC_CITY_IX
--------------------------------------------------------

CREATE INDEX "HR"."LOC_CITY_IX" ON "HR"."LOCATIONS" ("CITY");
--------------------------------------------------------
--  DDL for Index JHIST_JOB_IX
--------------------------------------------------------

CREATE INDEX "HR"."JHIST_JOB_IX" ON "HR"."JOB_HISTORY" ("JOB_ID");
--------------------------------------------------------
--  DDL for Index LOC_COUNTRY_IX
--------------------------------------------------------

CREATE INDEX "HR"."LOC_COUNTRY_IX" ON "HR"."LOCATIONS" ("COUNTRY_ID");
--------------------------------------------------------
--  DDL for Index EMP_JOB_IX
--------------------------------------------------------

CREATE INDEX "HR"."EMP_JOB_IX" ON "HR"."EMPLOYEES" ("JOB_ID");
--------------------------------------------------------
--  DDL for Index DEPT_LOCATION_IX
--------------------------------------------------------

CREATE INDEX "HR"."DEPT_LOCATION_IX" ON "HR"."DEPARTMENTS" ("LOCATION_ID");
--------------------------------------------------------
--  DDL for Index LOC_STATE_PROVINCE_IX
--------------------------------------------------------

CREATE INDEX "HR"."LOC_STATE_PROVINCE_IX" ON "HR"."LOCATIONS" ("STATE_PROVINCE");
--------------------------------------------------------
--  DDL for Index JHIST_DEPARTMENT_IX
--------------------------------------------------------

CREATE INDEX "HR"."JHIST_DEPARTMENT_IX" ON "HR"."JOB_HISTORY" ("DEPARTMENT_ID");
--------------------------------------------------------
--  DDL for Index EMP_FNAME_UPPERCASE_IDX
--------------------------------------------------------

CREATE INDEX "HR"."EMP_FNAME_UPPERCASE_IDX" ON "HR"."EMPLOYEES" (UPPER("FIRST_NAME"), UPPER("LAST_NAME"));
--------------------------------------------------------
--  DDL for Index EMP_MANAGER_IX
--------------------------------------------------------

CREATE INDEX "HR"."EMP_MANAGER_IX" ON "HR"."EMPLOYEES" ("MANAGER_ID");
--------------------------------------------------------
--  DDL for Index EMP_NAME_IX
--------------------------------------------------------

CREATE INDEX "HR"."EMP_NAME_IX" ON "HR"."EMPLOYEES" ("LAST_NAME", "FIRST_NAME");
--------------------------------------------------------
--  DDL for Index EMP_DEPARTMENT_IX
--------------------------------------------------------

CREATE INDEX "HR"."EMP_DEPARTMENT_IX" ON "HR"."EMPLOYEES" ("DEPARTMENT_ID");
--------------------------------------------------------
--  DDL for Trigger UPDATE_JOB_HISTORY
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER "HR"."UPDATE_JOB_HISTORY"
  AFTER UPDATE OF job_id, department_id ON employees
    FOR EACH ROW
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate,
                  :old.job_id, :old.department_id);
END;
/
ALTER TRIGGER "HR"."UPDATE_JOB_HISTORY" ENABLE;

--------------------------------------------------------
--  DDL for Procedure ADD_JOB_HISTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "HR"."ADD_JOB_HISTORY"
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type
   )
IS
BEGIN
    INSERT INTO job_history (employee_id, start_date, end_date,
                             job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;

/

--------------------------------------------------------
--  DDL for Procedure EMP_INFO_TO_ARRAY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "EMP_INFO_TO_ARRAY"
(p_id_dep employees.department_id%type)
AS
    CURSOR Cur_Emp_Dep IS
        SELECT employee_id, job_id
        FROM employees
        where department_id = p_id_dep;

    TYPE t_empId_jobId IS TABLE OF VARCHAR2(10) INDEX BY PLS_INTEGER;
    v_empId_jobId t_empId_jobId;


    TYPE t_empId_jobTitle IS TABLE OF VARCHAR2(35) INDEX BY PLS_INTEGER;
    v_empId_jobTitle t_empId_jobTitle;

    j Integer;
    i Integer;
    jb_title varchar(35);
    e_full_name VARCHAR(50);

BEGIN

    FOR ITEM IN Cur_Emp_Dep LOOP
               v_empId_jobId(ITEM.employee_id) := ITEM.job_id;
    END LOOP;

    IF v_empId_jobId.count > 0 then
        i := v_empId_jobId.FIRST;
        while i is not null loop
        select JOB_TITLE into jb_title from jobs where jobs.job_id = v_empId_jobId(i);
        if (jb_title is not null) then
                v_empId_jobTitle(i) := jb_title;
        end if;
            i := v_empId_jobId.NEXT(i);
        end loop;
    end if;


    j := v_empId_jobTitle.FIRST;


    WHILE  j IS NOT NULL LOOP
    GET_FULL_NAME( j, e_full_name);
    DBMS_Output.PUT_LINE
    ('id сотрудника ' ||  j || ', имя ' || e_full_name ||  ' , job_title ' || v_empId_jobTitle(j));
     j := v_empId_jobTitle.NEXT( j);
    END LOOP;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN null;
END;


CREATE OR REPLACE PROCEDURE "GET_FULL_NAME" (
    p_employee_id IN NUMBER,
    full_name OUT VARCHAR2
)
AS
    f_name employees.first_name%type;
    l_name employees.last_name%type;
BEGIN
    SELECT first_name, last_name
    INTO f_name, l_name
    FROM employees
    WHERE employee_id = p_employee_id;

    combine_and_format_names(f_name, l_name, full_name);
END;

/

CREATE OR REPLACE PROCEDURE combine_and_format_names
(
    first_name_inout IN VARCHAR2,
    last_name_inout IN VARCHAR2,
    full_name_out OUT VARCHAR2
)
IS
BEGIN

    full_name_out := UPPER (last_name_inout) || ' ' || UPPER (first_name_inout);

END;


/
--------------------------------------------------------
--  DDL for Package UPDATE_SALARY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "HR"."UPDATE_SALARY_PKG"
as
    PROCEDURE UPDATE_SALARY
    (emp_id number, new_salary number);
end;

/
--------------------------------------------------------
--  DDL for Package Body UPDATE_SALARY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "HR"."UPDATE_SALARY_PKG"
as

    PROCEDURE "GET_EMPLOYEE_DETAILS" (
        p_employee_id IN NUMBER,
        p_hire_date OUT DATE
    ) AS
    BEGIN
        SELECT hire_date
        INTO p_hire_date
        FROM employees
        WHERE employee_id = p_employee_id;
    END get_employee_details;

    FUNCTION  "GET_RATE" (dep_id number)
    return number
    IS
        rate number(8,2);
        empl_hire_date DATE;
    begin
        GET_EMPLOYEE_DETAILS(dep_id, empl_hire_date);

        case
            when MONTHS_BETWEEN(SYSDATE, empl_hire_date) / 12 > 8 then rate := 1.4;
            when MONTHS_BETWEEN(SYSDATE, empl_hire_date) / 12 > 6 then rate := 1.2;
            else rate := 1.0;
        end case;
    RETURN rate;
    end;

    PROCEDURE UPDATE_SALARY
    (emp_id number, new_salary number)
    AS
        employee_rowid ROWID;
        employee_salary NUMBER;
        rate number(8,2);
    BEGIN

        SELECT rowid INTO employee_rowid
        FROM employees
        WHERE employee_id = emp_id;

        rate := GET_RATE(emp_id);
        UPDATE employees
        SET salary = new_salary * rate
        WHERE rowid = employee_rowid;
    end;

end;

/

CREATE OR REPLACE FUNCTION COUNT_AVERAGE_SALARY
(
    dept_id number
)
    RETURN NUMBER
IS
    CURSOR sal_cur (id_department in number)
    IS
    SELECT AVG(SALARY)
        FROM employees
        WHERE department_id = id_department;
    sal_rec NUMBER;
BEGIN
    OPEN sal_cur(dept_id);
    FETCH sal_cur INTO sal_rec;

RETURN sal_rec;
END;


--------------------------------------------------------
--  Constraints for Table JOB_HISTORY
--------------------------------------------------------

ALTER TABLE "JOB_HISTORY" MODIFY ("EMPLOYEE_ID" CONSTRAINT "JHIST_EMPLOYEE_NN" NOT NULL ENABLE)
ALTER TABLE "JOB_HISTORY" MODIFY ("START_DATE" CONSTRAINT "JHIST_START_DATE_NN" NOT NULL ENABLE)
ALTER TABLE "JOB_HISTORY" MODIFY ("END_DATE" CONSTRAINT "JHIST_END_DATE_NN" NOT NULL ENABLE)
ALTER TABLE "JOB_HISTORY" MODIFY ("JOB_ID" CONSTRAINT "JHIST_JOB_NN" NOT NULL ENABLE)
ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date) ENABLE
ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table COUNTRIES
--------------------------------------------------------

ALTER TABLE "COUNTRIES" MODIFY ("COUNTRY_ID" CONSTRAINT "COUNTRY_ID_NN" NOT NULL ENABLE)
ALTER TABLE "COUNTRIES" ADD CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table REGIONS
--------------------------------------------------------

ALTER TABLE "REGIONS" MODIFY ("REGION_ID" CONSTRAINT "REGION_ID_NN" NOT NULL ENABLE)
ALTER TABLE "REGIONS" ADD CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table JOBS
--------------------------------------------------------

ALTER TABLE "JOBS" MODIFY ("JOB_TITLE" CONSTRAINT "JOB_TITLE_NN" NOT NULL ENABLE)
ALTER TABLE "JOBS" ADD CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table LOCATIONS
--------------------------------------------------------

ALTER TABLE "LOCATIONS" MODIFY ("CITY" CONSTRAINT "LOC_CITY_NN" NOT NULL ENABLE)
ALTER TABLE "LOCATIONS" ADD CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID") USING INDEX  ENABLE

--------------------------------------------------------
--  Constraints for Table DEPARTMENTS
--------------------------------------------------------

ALTER TABLE "DEPARTMENTS" MODIFY ("DEPARTMENT_NAME" CONSTRAINT "DEPT_NAME_NN" NOT NULL ENABLE)
ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table EMPLOYEES
--------------------------------------------------------

ALTER TABLE "EMPLOYEES" MODIFY ("LAST_NAME" CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE)
ALTER TABLE "EMPLOYEES" MODIFY ("EMAIL" CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE)
ALTER TABLE "EMPLOYEES" MODIFY ("HIRE_DATE" CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE)
ALTER TABLE "EMPLOYEES" MODIFY ("JOB_ID" CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE)
ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0) ENABLE
ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL") USING INDEX  ENABLE
ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID") USING INDEX  ENABLE

--------------------------------------------------------
--  Ref Constraints for Table COUNTRIES
--------------------------------------------------------

ALTER TABLE "COUNTRIES" ADD CONSTRAINT "COUNTR_REG_FK" FOREIGN KEY ("REGION_ID") REFERENCES "REGIONS" ("REGION_ID") ENABLE

--------------------------------------------------------
--  Ref Constraints for Table DEPARTMENTS
--------------------------------------------------------

ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID") REFERENCES "LOCATIONS" ("LOCATION_ID") ENABLE
ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ENABLE

--------------------------------------------------------
--  Ref Constraints for Table EMPLOYEES
--------------------------------------------------------

ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID") ENABLE
ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID") REFERENCES "JOBS" ("JOB_ID") ENABLE
ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ENABLE

--------------------------------------------------------
--  Ref Constraints for Table JOB_HISTORY
--------------------------------------------------------

ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY ("JOB_ID") REFERENCES "JOBS" ("JOB_ID") ENABLE
ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY ("EMPLOYEE_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ENABLE
ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table LOCATIONS
--------------------------------------------------------

ALTER TABLE "LOCATIONS" ADD CONSTRAINT "LOC_C_ID_FK" FOREIGN KEY ("COUNTRY_ID") REFERENCES "COUNTRIES" ("COUNTRY_ID") ENABLE
--------------------------------------------------------

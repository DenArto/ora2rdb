  CREATE TABLE "TESTS_TABLES_PARTITION"."EMPLOYEES2"
   (
    "EMPLOYEE_ID" NUMBER NOT NULL ENABLE,
	"FIRST_NAME" VARCHAR2(50 BYTE) NOT NULL ENABLE,
	"LAST_NAME" VARCHAR2(50 BYTE) NOT NULL ENABLE,
	"JOB_TITLE" VARCHAR2(100 BYTE),
	"HIRE_DATE" DATE DEFAULT SYSDATE,
	"SALARY" NUMBER(10, 2),
	 PRIMARY KEY ("EMPLOYEE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255
  TABLESPACE "SYSAUX"  ENABLE
   ) SEGMENT CREATION DEFERRED ORGANIZATION HEAP
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS LOGGING
  TABLESPACE "SYSAUX";
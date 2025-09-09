/*Found error(s) in file while parsing
Error at line 12:33 - no viable alternative at input 'CREATE TABLE sales(acct_no NUMBER(5),\n                   acct_name CHAR(30),\n                   amount_of_sale NUMBER(6),\n                   week_no INTEGER,\n                   sale_details VARCHAR2(1000),\n             PRIMARY KEY (acct_no, acct_name, week_no))\n     ORGANIZATION INDEX\n             INCLUDING week_no\n             OVERFLOW TABLESPACE overflow_here\n     PARTITION BY RANGE (week_no)\n            (PARTITION VALUES LESS THAN (5)\n                   TABLESPACE ts1,'
*/

-- RS-243163

/*
Error at line 12:33 - no viable alternative at input 'CREATE TABLE sales(acct_no NUMBER(5),\n                   acct_name CHAR(30),\n                   amount_of_sale NUMBER(6),\n                   week_no INTEGER,\n                   sale_details VARCHAR2(1000),\n             PRIMARY KEY (acct_no, acct_name, week_no))\n     ORGANIZATION INDEX\n             INCLUDING week_no\n             OVERFLOW TABLESPACE overflow_here\n     PARTITION BY RANGE (week_no)\n            (PARTITION VALUES LESS THAN (5)\n                   TABLESPACE ts1,'
CREATE TABLE sales(acct_no NUMBER(5),
                   acct_name CHAR(30),
                   amount_of_sale NUMBER(6),
                   week_no INTEGER,
                   sale_details VARCHAR2(1000),
             PRIMARY KEY (acct_no, acct_name, week_no))
     ORGANIZATION INDEX
             INCLUDING week_no
             OVERFLOW TABLESPACE overflow_here
     PARTITION BY RANGE (week_no)
            (PARTITION VALUES LESS THAN (5)
                   TABLESPACE ts1,
             PARTITION VALUES LESS THAN (9)
                   TABLESPACE ts2 OVERFLOW TABLESPACE overflow_ts2,
             PARTITION VALUES LESS THAN (MAXVALUE)
                   TABLESPACE ts13);
*/
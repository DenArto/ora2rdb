/*CREATE TABLE sales(acct_no NUMERIC(5),
                   acct_name CHAR(30),
                   amount_of_sale NUMERIC(6),
                   week_no INTEGER,
                   sale_details VARCHAR(1000),
             PRIMARY KEY (acct_no, acct_name, week_no))[-unconvertible RS-243394 PARTITION BY HASH (week_no)
             PARTITIONS 16
             STORE IN (ts1, ts2, ts3, ts4)
             OVERFLOW STORE IN (ts3, ts6, ts9)];*/
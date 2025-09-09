/*CREATE TABLE departments_hash (
    department_id NUMERIC(4) NOT NULL,
    department_name VARCHAR(30))[-unconvertible RS-243394 PARTITION BY HASH(department_id)
    (PARTITION p1 TABLESPACE ts1, PARTITION p2 TABLESPACE ts2,
    PARTITION p3 TABLESPACE ts1, PARTITION p4 TABLESPACE ts3)];*/
SELECT salary FROM employees
    AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '1' MINUTE)
    WHERE last_name = 'Chung';
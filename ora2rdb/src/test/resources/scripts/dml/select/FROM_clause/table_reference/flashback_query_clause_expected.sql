/* Convert this expression "AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '1' MINUTE)" by yourself */
 SELECT salary FROM employees
    [-unconvertible AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '1' MINUTE)]
    WHERE last_name = 'Chung';
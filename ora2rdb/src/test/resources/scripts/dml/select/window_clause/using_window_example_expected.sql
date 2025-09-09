SELECT
    emp_no,
    dept_no,
    salary,
    count(*) OVER w1,
        first_value(salary) OVER w2,
        last_value(salary) OVER w2,
        sum(salary) over (w2 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS s
FROM employee
         WINDOW w1 AS (PARTITION BY DEPT_NO),
			w2 AS (w1 ORDER BY salary ASC NULLS LAST)
ORDER BY dept_no ASC NULLS LAST, salary ASC NULLS LAST;
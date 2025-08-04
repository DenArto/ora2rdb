/*SELECT empno, deptno, sal,
       [-unconvertible RS-244710 VARIANCE(sal)] OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      ROWS 1 PRECEDING) AS rows_avg
FROM emp;*/
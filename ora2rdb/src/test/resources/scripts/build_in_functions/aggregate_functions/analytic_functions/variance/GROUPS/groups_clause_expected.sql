/*SELECT empno, deptno, sal,
       [-unconvertible RS-244710 VARIANCE(sal)] OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      [-unconvertible RS-244675 GROUPS between 1 preceding and current row]) AS rows_avg
FROM emp;*/
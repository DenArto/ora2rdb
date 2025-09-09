SELECT empno, deptno, sal,
       STDDEV_POP(sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      RANGE 1 PRECEDING) AS rows_avg
FROM emp;
SELECT empno, deptno, sal,
      STDDEV_SAMP(sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      ROWS UNBOUNDED PRECEDING) AS rows_avg
FROM emp;
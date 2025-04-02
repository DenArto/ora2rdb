SELECT empno, deptno, sal,
       checksum(sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE 1 PRECEDING) AS rows_avg
FROM emp;
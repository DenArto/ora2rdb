/*SELECT empno, deptno, sal,
       [-unconvertible RS-244710 checksum(sal)] OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      RANGE CURRENT ROW) AS rows_avg
FROM emp;*/
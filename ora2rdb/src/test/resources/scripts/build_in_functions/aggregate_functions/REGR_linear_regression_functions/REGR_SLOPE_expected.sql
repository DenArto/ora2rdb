SELECT empno,
REGR_SLOPE(CURRENT_TIMESTAMP-hiredate, sal) slp
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno ASC NULLS LAST;
SELECT empno,
REGR_INTERCEPT(CURRENT_TIMESTAMP-hiredate, sal) interc
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno
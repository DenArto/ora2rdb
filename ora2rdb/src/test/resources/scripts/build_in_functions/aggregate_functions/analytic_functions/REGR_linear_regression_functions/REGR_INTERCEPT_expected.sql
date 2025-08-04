SELECT empno,
REGR_INTERCEPT(CURRENT_TIMESTAMP-hiredate, sal)
OVER (PARTITION BY deptno)
interc
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno ASC NULLS LAST;
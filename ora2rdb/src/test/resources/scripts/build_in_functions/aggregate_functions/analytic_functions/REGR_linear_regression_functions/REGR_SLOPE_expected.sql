SELECT empno,
REGR_SLOPE(CURRENT_TIMESTAMP-hiredate, sal)
OVER (PARTITION BY deptno)
slp
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno ASC NULLS LAST;
SELECT empno,
REGR_SXX(CURRENT_TIMESTAMP-hiredate, sal)
OVER (PARTITION BY deptno)
sxx
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno ASC NULLS LAST;
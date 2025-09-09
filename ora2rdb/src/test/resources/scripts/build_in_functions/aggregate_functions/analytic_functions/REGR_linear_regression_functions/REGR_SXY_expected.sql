SELECT empno,
REGR_SXY(CURRENT_TIMESTAMP-hiredate, sal)
OVER (PARTITION BY deptno)
sxy
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno ASC NULLS LAST;
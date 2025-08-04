SELECT empno,
REGR_R2(CURRENT_TIMESTAMP-hiredate, sal)
OVER (PARTITION BY deptno)
r2
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno ASC NULLS LAST;
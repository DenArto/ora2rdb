SELECT empno,
REGR_AVGX(CURRENT_TIMESTAMP-hiredate, sal)
OVER (PARTITION BY deptno)
avgx
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno ASC NULLS LAST;
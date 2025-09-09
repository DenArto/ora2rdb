SELECT empno,
REGR_SYY(CURRENT_TIMESTAMP-hiredate, sal)
OVER (PARTITION BY deptno)
syy
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno ASC NULLS LAST;
SELECT empno,
REGR_AVGY(CURRENT_TIMESTAMP-hiredate, sal)
OVER (PARTITION BY deptno)
avgy
   FROM emp
   where deptno in (20, 30, 10)
   ORDER BY empno ASC NULLS LAST;
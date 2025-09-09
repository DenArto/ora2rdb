SELECT empno,
REGR_AVGY(CURRENT_TIMESTAMP-hiredate, sal) avgy
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno ASC NULLS LAST;
SELECT empno,
REGR_COUNT(CURRENT_TIMESTAMP-hiredate, sal) cnt
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno ASC NULLS LAST;
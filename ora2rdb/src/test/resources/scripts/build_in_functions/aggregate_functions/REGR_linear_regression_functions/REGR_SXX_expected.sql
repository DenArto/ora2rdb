SELECT empno,
REGR_SXX(CURRENT_TIMESTAMP-hiredate, sal) sxx
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno ASC NULLS LAST;
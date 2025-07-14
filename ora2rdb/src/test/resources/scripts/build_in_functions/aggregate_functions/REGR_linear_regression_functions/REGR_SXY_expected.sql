SELECT empno,
REGR_SXY(CURRENT_TIMESTAMP-hiredate, sal) sxy
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno ASC NULLS LAST;
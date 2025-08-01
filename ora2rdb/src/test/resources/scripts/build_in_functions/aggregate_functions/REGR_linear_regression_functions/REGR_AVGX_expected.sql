SELECT empno,
REGR_AVGX(CURRENT_TIMESTAMP-hiredate, sal) avgx
   FROM emp
   where deptno in (20, 30, 10)
   GROUP BY empno
   ORDER BY empno ASC NULLS LAST;
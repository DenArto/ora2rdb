SELECT empno, ename, sal, comm AS sum_total
FROM emp
order by  sal DESC NULLS FIRST, comm ASC NULLS LAST;
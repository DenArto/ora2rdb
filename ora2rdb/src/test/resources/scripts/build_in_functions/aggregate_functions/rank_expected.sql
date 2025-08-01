SELECT empno,
       ename,
       deptno,
       sal,
       RANK() OVER (ORDER BY sal ASC NULLS LAST) AS percent_rank_sal
FROM emp;
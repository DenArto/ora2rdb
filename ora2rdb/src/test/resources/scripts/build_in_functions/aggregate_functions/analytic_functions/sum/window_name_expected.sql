select row_number () over (order by sal ASC NULLS LAST) as row_order,
       sal,
       SUM(sal) over w1 as avg_rows
from emp
window w1 as (order by sal ASC NULLS LAST rows between 1 preceding and current row);
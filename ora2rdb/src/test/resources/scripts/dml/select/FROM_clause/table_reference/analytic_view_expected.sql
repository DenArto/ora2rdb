/*WITH
    [-unconvertible RS-241324 my_av ANALYTIC VIEW AS (
    USING sales_av [-unconvertible RS-241349 HIERARCHIES (time_hier)]
    ADD MEASURES (
    lag_sales AS (LAG(sales) OVER (HIERARCHY time_hier OFFSET 1))
    )
    )]
SELECT time_hier.member_name time, sales, lag_sales
FROM my_av [-unconvertible RS-241349 HIERARCHIES (time_hier)]
WHERE time_hier.level_name = 'YEAR'
ORDER BY time_hier.hier_order ASC NULLS LAST;*/
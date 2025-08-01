SELECT PERCENT_RANK(15000, .05) WITHIN GROUP
       (ORDER BY salary ASC NULLS LAST, commission_pct ASC NULLS LAST) "Percent-Rank"
  FROM employees;
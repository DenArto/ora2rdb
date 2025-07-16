MERGE /*+ USE_MERGE(bonuses2 bonuses) */
INTO bonuses 
   USING bonuses2
   ON (bonuses.employee_id = bonuses2.employee_id)
    WHEN NOT MATCHED THEN INSERT (bonus) VALUES (3);

MERGE --+ USE_MERGE(bonuses2 bonuses)
INTO bonuses 
   USING bonuses2
   ON (bonuses.employee_id = bonuses2.employee_id)
    WHEN NOT MATCHED THEN INSERT (bonus) VALUES (3);
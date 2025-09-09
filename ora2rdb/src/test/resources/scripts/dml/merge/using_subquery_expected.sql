MERGE INTO bonuses 
   USING (Select employee_id from bonuses2) S
   ON (bonuses.employee_id = S.employee_id)
   WHEN NOT MATCHED THEN INSERT (bonus) VALUES (4);
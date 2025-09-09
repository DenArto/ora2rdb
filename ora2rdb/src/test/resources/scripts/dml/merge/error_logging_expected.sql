 /*MERGE INTO bonuses T
   USING bonuses2 S
   ON (T.employee_id = S.employee_id)
    WHEN NOT MATCHED 
    THEN INSERT (employee_id, bonus) VALUES (S.employee_id, 200)
    [-unconvertible RS-242476 LOG ERRORS INTO errlog ('my_bad') REJECT LIMIT 10];*/
/*MERGE INTO bonuses t
   USING bonuses2 s
   ON (t.employee_id = s.employee_id)
    WHEN MATCHED THEN UPDATE SET bonus = 700
    [-unconvertible RS-242485 WHERE s.employee_id < 160]
    [-unconvertible RS-242478 DELETE WHERE t.bonus = 700];*/
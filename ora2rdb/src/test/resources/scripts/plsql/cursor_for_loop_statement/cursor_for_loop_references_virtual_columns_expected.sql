EXECUTE BLOCK
 AS
/*BEGIN
[-unconvertible RS-243534 FOR (
    SELECT first_name || ' ' || last_name AS full_name,
    salary * 10                    AS dream_salary
    FROM employees
  ) INTO item DO
BEGIN
]
        item.full_name = 'UNKNOWN';
        item.dream_salary = 0;
    END
END;*/
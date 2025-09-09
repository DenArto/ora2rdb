SELECT CAST(345.45 AS VARCHAR(32765)) FROM RDB$DATABASE;

SELECT
-- TO_CHAR function used format '$9' ,which is not supported in RDB
CAST(-1 AS VARCHAR(32765) ) FROM RDB$DATABASE;

SELECT
-- TO_CHAR function used format 'L99G999D99MI' ,which is not supported in RDB
CAST(-10000 AS VARCHAR(32765)) FROM RDB$DATABASE;

SELECT
-- TO_CHAR function used format 'L99G999D99MI' ,which is not supported in RDB
CAST(-10000 AS VARCHAR(32765) ) FROM RDB$DATABASE;
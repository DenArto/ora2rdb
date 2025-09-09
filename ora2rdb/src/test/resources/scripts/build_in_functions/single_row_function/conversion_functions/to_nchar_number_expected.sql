SELECT CAST( AS NCHAR VARYING(32765) ) FROM RDB$DATABASE;

SELECT
-- TO_NCHAR function used format '$9' ,which is not supported in RDB
CAST(  AS NCHAR VARYING(32765) ) FROM RDB$DATABASE;
SELECT
-- TO_NCHAR function used format 'L99G999D99MI' ,which is not supported in RDB
CAST( AS NCHAR VARYING(32765) ) FROM RDB$DATABASE;

SELECT
-- TO_NCHAR function used format 'L99G999D99MI' ,which is not supported in RDB
CAST(  AS NCHAR VARYING(32765) ) FROM RDB$DATABASE;
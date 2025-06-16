SELECT CAST('345.45' AS NUMERIC(34,8)) FROM RDB$DATABASE;

/*
select [-unconvertible TO_NUMBER('$100.00', '$999.99')] from dual;
/*
/*
SELECT [-unconvertible TO_NUMBER('-AusDollars100','L9G999D99',
   ' NLS_NUMERIC_CHARACTERS = '',.''
     NLS_CURRENCY = ''AusDollars'' ')] FROM DUAL;
*/

SELECT CAST('2,00' AS NUMERIC(34,8)) FROM RDB$DATABASE;

/*
select [-unconvertible TO_NUMBER('100.00' DEFAULT 0 ON CONVERSION ERROR, '9G999D99')] from dual;
*/
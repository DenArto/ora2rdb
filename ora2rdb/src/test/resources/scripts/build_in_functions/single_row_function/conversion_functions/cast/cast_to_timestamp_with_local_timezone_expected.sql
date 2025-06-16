/*
DECLARE
  p1 VARCHAR2(100) := '22-OCT-1997';
  p2 DATE := date '2020-10-25';
  p3 TIMESTAMP := timestamp '2020-10-25 02:30:00';
  p4 TIMESTAMP WITH TIME ZONE := timestamp '2020-10-25 02:30:00+02:00';
  [-unconvertible res TIMESTAMP WITH LOCAL TIME ZONE;]
BEGIN
  select [-unconvertible CAST(p1 AS TIMESTAMP WITH LOCAL TIME ZONE)] into res from dual;
  select [-unconvertible CAST(p1 AS TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL ON CONVERSION ERROR)] into res from dual;
  select [-unconvertible CAST(p1 AS TIMESTAMP WITH LOCAL TIME ZONE, 'DD-Mon-YYYY')] into res from dual;
  select [-unconvertible CAST(p1 AS TIMESTAMP WITH LOCAL TIME ZONE, 'DD-Mon-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;
  select [-unconvertible CAST(p1 AS TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL ON CONVERSION ERROR, 'DD-Mon-YYYY', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;

  select [-unconvertible CAST(p2 AS TIMESTAMP WITH LOCAL TIME ZONE)] into res from dual;
  select [-unconvertible CAST(p2 AS TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL ON CONVERSION ERROR)] into res from dual;
  select [-unconvertible CAST(p2 AS TIMESTAMP WITH LOCAL TIME ZONE, 'YYYY-MM-DD')] into res from dual;
  select [-unconvertible CAST(p2 AS TIMESTAMP WITH LOCAL TIME ZONE, 'YYYY-MM-DD', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;  
  select [-unconvertible CAST(p2 AS TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL ON CONVERSION ERROR, 'YYYY-MM-DD', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;

  select [-unconvertible CAST(p3 AS TIMESTAMP WITH LOCAL TIME ZONE)] into res from dual;
  select [-unconvertible CAST(p3 AS TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL ON CONVERSION ERROR)] into res from dual;
  select [-unconvertible CAST(p3 AS TIMESTAMP WITH LOCAL TIME ZONE, 'DD.MM.YY HH24:MI:SSXFF9')] into res from dual;
  select [-unconvertible CAST(p3 AS TIMESTAMP WITH LOCAL TIME ZONE, 'DD.MM.YY HH24:MI:SSXFF9', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;  
  select [-unconvertible CAST(p3 AS TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL ON CONVERSION ERROR, 'DD.MM.YY HH24:MI:SSXFF9', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual; 

  select [-unconvertible CAST(p4 AS TIMESTAMP WITH LOCAL TIME ZONE)] into res from dual;
  select [-unconvertible CAST(p4 AS TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL ON CONVERSION ERROR)] into res from dual;
  select [-unconvertible CAST(p4 AS TIMESTAMP WITH LOCAL TIME ZONE, 'DD.MM.YY HH24:MI:SSXFF9TZR')] into res from dual;
  select [-unconvertible CAST(p4 AS TIMESTAMP WITH LOCAL TIME ZONE, 'DD.MM.YY HH24:MI:SSXFF9TZR', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;  
  select [-unconvertible CAST(p4 AS TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL ON CONVERSION ERROR, 'DD.MM.YY HH24:MI:SSXFF9TZR', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;
END;
*/
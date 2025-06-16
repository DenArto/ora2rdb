/*
DECLARE
  p1 VARCHAR2(100) := '2 05:30:00';
  [-unconvertible res INTERVAL DAY TO SECOND;]
BEGIN
  select [-unconvertible CAST(p1 AS INTERVAL DAY TO SECOND)] into res from dual;
  select [-unconvertible CAST(p1 AS INTERVAL DAY TO SECOND DEFAULT NULL ON CONVERSION ERROR)] into res from dual;
END;
*/
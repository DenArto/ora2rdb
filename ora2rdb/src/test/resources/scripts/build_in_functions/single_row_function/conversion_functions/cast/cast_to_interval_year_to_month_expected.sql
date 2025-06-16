/*
DECLARE
  p1 VARCHAR2(100) := '3-6';
  [-unconvertible res INTERVAL YEAR TO MONTH;]
BEGIN
  select [-unconvertible CAST(p1 AS INTERVAL YEAR TO MONTH)] into res from dual;
  select [-unconvertible CAST(p1 AS INTERVAL YEAR TO MONTH DEFAULT NULL ON CONVERSION ERROR)] into res from dual;
END;
*/
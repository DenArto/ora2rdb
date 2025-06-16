DECLARE
  p1 CHAR(10) := '48656C6C6F';
  res RAW(56);
BEGIN
  select CAST(p1 AS RAW(56)) into res from dual;
END;
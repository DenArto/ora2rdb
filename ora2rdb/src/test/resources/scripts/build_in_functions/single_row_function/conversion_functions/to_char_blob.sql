DECLARE
  p1 BLOB;
  res VARCHAR2(100);
BEGIN
  select TO_CHAR(p1) into res from dual;
  select TO_CHAR(p1, 873) into res from dual;
END;
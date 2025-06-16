DECLARE
  p2 BFILE;
  res VARCHAR2(100);
BEGIN 
  select TO_CHAR(p2, 873) into res from dual;
END;
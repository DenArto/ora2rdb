DECLARE
  p1 CHAR(6) := 'hello';
  p2 VARCHAR2(6) := 'world';
  p3 CLOB := 'hello';
  p4 NCLOB := 'world';
  res NVARCHAR2(100);
BEGIN
  select TO_NCHAR(p1) into res from dual;
  
  select TO_NCHAR(p2) into res from dual;
    
  select TO_NCHAR(p3) into res from dual;
  
  select TO_NCHAR(p4) into res from dual;
END;
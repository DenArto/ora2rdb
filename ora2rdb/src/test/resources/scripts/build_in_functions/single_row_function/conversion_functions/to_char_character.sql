DECLARE
  p1 NCHAR(10) := 'hello';
  p2 NVARCHAR2(10) := 'world';
  p3 CLOB := 'hello';
  p4 NCLOB := 'world';
  res VARCHAR2(100);
BEGIN
  select TO_CHAR(p1) into res from dual;
  
  select TO_CHAR(p2) into res from dual;
    
  select TO_CHAR(p3) into res from dual;
  
  select TO_CHAR(p4) into res from dual;
END;
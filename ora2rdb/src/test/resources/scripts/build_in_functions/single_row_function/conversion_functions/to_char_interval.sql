DECLARE
  p1 INTERVAL DAY TO SECOND := INTERVAL '1' DAY;
  p2 INTERVAL YEAR TO MONTH := interval '10' year;
  res VARCHAR2(100);
BEGIN
  select TO_CHAR(p1) into res from dual;
  select TO_CHAR(p1, 'DD') into res from dual;
  select TO_CHAR(p1, 'DD', 'NLS_DATE_LANGUAGE = american') into res from dual;
  
  select TO_CHAR(p2) into res from dual;
  select TO_CHAR(p2, 'YYYY') into res from dual;
  select TO_CHAR(p2, 'YYYY', 'NLS_DATE_LANGUAGE = american') into res from dual;
END;
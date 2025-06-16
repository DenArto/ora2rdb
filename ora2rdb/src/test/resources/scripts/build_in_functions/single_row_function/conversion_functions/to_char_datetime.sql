DECLARE
  p1 DATE :=  date '2011-11-03';
  p2 TIMESTAMP := LOCALTIMESTAMP;
  p3 TIMESTAMP WITH TIME ZONE := CURRENT_TIMESTAMP;
  res VARCHAR2(100);
BEGIN
  select TO_CHAR(p1) into res from dual;
  select TO_CHAR(p1, 'DD-MON-YYYY') into res from dual;
  select TO_CHAR(p1, 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = american') into res from dual;
  
  select TO_CHAR(p2) into res from dual;
  select TO_CHAR(p2, 'HH24:MI:SSxFF DD-MON-YYYY') into res from dual;
  select TO_CHAR(p2, 'HH24:MI:SSxFF DD-MON-YYYY', 'NLS_DATE_LANGUAGE = american') into res from dual;
    
  select TO_CHAR(p3) into res from dual;
  select TO_CHAR(p3, 'HH24:MI:SSxFF DD-MON-YYYY') into res from dual;
  select TO_CHAR(p3, 'HH24:MI:SSxFF DD-MON-YYYY', 'NLS_DATE_LANGUAGE = american') into res from dual;
END;

DECLARE
  p4 TIMESTAMP WITH LOCAL TIME ZONE := timestamp '2020-10-25 02:30:00+02:00';
  res VARCHAR2(100);
BEGIN
  select TO_CHAR(p4) into res from dual;
  select TO_CHAR(p4, 'DD-MON-YYYY') into res from dual;
  select TO_CHAR(p4, 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = american') into res from dual;
END;
DECLARE
  p1 BINARY_DOUBLE := 123.45;
  p2 BINARY_FLOAT := 123.45;
  p3 NVARCHAR2(6) := 'hello';
  p4 NUMBER := 100;
  p5 DATE :=  date '2011-11-03';
  p6 TIMESTAMP := LOCALTIMESTAMP;
  p7 TIMESTAMP WITH TIME ZONE := CURRENT_TIMESTAMP;
  p11 RAW(56) := utl_raw.cast_to_raw('hello');
  res NCHAR(100);
BEGIN
  select CAST(p1 AS NCHAR(100)) into res from dual;
  
  select CAST(p2 AS NCHAR(100)) into res from dual;
    
  select CAST(p3 AS NCHAR(100)) into res from dual;
  
  select CAST(p4 AS NCHAR(100)) into res from dual;

  select CAST(p5 AS NCHAR(100)) into res from dual;

  select CAST(p6 AS NCHAR(100)) into res from dual;

  select CAST(p7 AS NCHAR(100)) into res from dual;

  select CAST(p11 AS NCHAR(100)) into res from dual;
END;

create table ttt(id int);

insert into ttt values (100);

DECLARE
  p8 TIMESTAMP WITH LOCAL TIME ZONE := timestamp '2020-10-25 02:30:00+02:00';
  p9 INTERVAL DAY TO SECOND := INTERVAL '1' DAY;
  p10 INTERVAL YEAR TO MONTH := interval '10' year;
  p12 ROWID;
  p13 UROWID;
  res NCHAR(100);
BEGIN
  select CAST(p8 AS NCHAR(100)) into res from dual;
  
  select CAST(p9 AS NCHAR(100)) into res from dual;

  select CAST(p10 AS NCHAR(100)) into res from dual;

  SELECT ROWID INTO p12
  FROM ttt WHERE ROWNUM = 1;

  SELECT ROWID INTO p13
  FROM ttt WHERE ROWNUM = 1;

  select CAST(p12 AS NCHAR(100)) into res from dual;
  select CAST(p13 AS NCHAR(100)) into res from dual;
END;
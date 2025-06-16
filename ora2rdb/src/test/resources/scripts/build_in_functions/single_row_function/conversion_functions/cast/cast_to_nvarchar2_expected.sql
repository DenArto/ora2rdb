EXECUTE BLOCK 
AS
  DECLARE p1 DECFLOAT(34) = 123.45;
  DECLARE p2 DECFLOAT(16) = 123.45;
  DECLARE p3 NCHAR VARYING(6) = 'hello';
  DECLARE p4 NUMERIC(34,8) = 100;
  DECLARE p5 DATE =  date '2011-11-03';
  DECLARE p6 TIMESTAMP = LOCALTIMESTAMP;
  DECLARE p7 TIMESTAMP WITH TIME ZONE = CURRENT_TIMESTAMP;
  DECLARE p11 BINARY(56) = 'hello';
  DECLARE res NCHAR VARYING(100);
BEGIN
  select CAST(:p1 AS NCHAR VARYING(100)) from rdb$database into :res;
  
  select CAST(:p2 AS NCHAR VARYING(100)) from rdb$database into :res;
    
  select CAST(:p3 AS NCHAR VARYING(100)) from rdb$database into :res;
  
  select CAST(:p4 AS NCHAR VARYING(100)) from rdb$database into :res;

  select CAST(:p5 AS NCHAR VARYING(100)) from rdb$database into :res;

  select CAST(:p6 AS NCHAR VARYING(100)) from rdb$database into :res;

  select CAST(:p7 AS NCHAR VARYING(100)) from rdb$database into :res;

  select CAST(:p11 AS NCHAR VARYING(100)) from rdb$database into :res;
END;

create table ttt(id int);

insert into ttt values (100);

/*
DECLARE
  [-unconvertible p8 TIMESTAMP WITH LOCAL TIME ZONE := timestamp '2020-10-25 02:30:00+02:00';]
  [-unconvertible p9 INTERVAL DAY TO SECOND := INTERVAL '1' DAY;]
  [-unconvertible p10 INTERVAL YEAR TO MONTH := interval '10' year;]
  [-unconvertible p12 ROWID;]
  [-unconvertible p13 UROWID;]
  res NVARCHAR2(100);
BEGIN
  select [-unconvertible CAST(p8 AS NVARCHAR2(100))] into res from dual;
  
  select [-unconvertible CAST(p9 AS NVARCHAR2(100))] into res from dual;

  select [-unconvertible CAST(p10 AS NVARCHAR2(100))] into res from dual;

  SELECT [-unconvertible ROWID] INTO p12
  FROM ttt WHERE ROWNUM = 1;

  SELECT [-unconvertible ROWID] INTO p13
  FROM ttt WHERE ROWNUM = 1;

  select [-unconvertible CAST(p12 AS NVARCHAR2(100))] into res from dual;
  select [-unconvertible CAST(p13 AS NVARCHAR2(100))] into res from dual;
END;
*/
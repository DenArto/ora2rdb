create table ttt(id int);
insert into ttt values (100);

/*
DECLARE
  p1 VARCHAR2(100);
  [-unconvertible p2 ROWID;]
  [-unconvertible res UROWID;]
BEGIN
  SELECT [-unconvertible ROWID] INTO p2
  FROM ttt WHERE ROWNUM = 1;
  select [-unconvertible CAST(p2 AS VARCHAR2(100))] into p1 from dual;

  select [-unconvertible CAST(p1 AS UROWID)] into res from dual;
  select [-unconvertible CAST(p2 AS UROWID)] into res from dual;
END; 
*/
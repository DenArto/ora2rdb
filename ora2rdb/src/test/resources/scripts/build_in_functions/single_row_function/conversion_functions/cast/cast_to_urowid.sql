create table ttt(id int);
insert into ttt values (100);

DECLARE
  p1 VARCHAR2(100);
  p2 ROWID;
  res UROWID;
BEGIN
  SELECT ROWID INTO p2
  FROM ttt WHERE ROWNUM = 1;
  select CAST(p2 AS VARCHAR2(100)) into p1 from dual;

  select CAST(p1 AS UROWID) into res from dual;
  select CAST(p2 AS UROWID) into res from dual;
END; 
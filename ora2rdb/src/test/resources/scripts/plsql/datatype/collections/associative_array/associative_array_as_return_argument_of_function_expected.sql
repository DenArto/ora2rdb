-- https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-collections-and-records.html#GUID-8060F01F-B53B-48D4-9239-7EA8461C2170:~:text=Example%206%2D2%20Function%20Returns%20Associative%20Array%20Indexed%20by%20PLS_INTEGER
--S SUM_MULTIPLES
CREATE GLOBAL TEMPORARY TABLE S (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_S PRIMARY KEY (K)
);


EXECUTE BLOCK
 AS

/*
--TYPE sum_multiples IS TABLE OF INTEGER INDEX BY INTEGER;
   DECLARE n  INTEGER = 5;   -- number of multiples to sum for display
   DECLARE sn INTEGER = 10;  -- number of multiples to sum
   DECLARE m  INTEGER = 3;   -- multiple

  DECLARE FUNCTION get_sum_multiples (
    multiple  INTEGER,
    num       INTEGER
  ) RETURNS sum_multiples
  AS
/*
    --s sum_multiples;
*/
BEGIN
/*
[-unconvertible RS-238758 FOR :i IN 1..:num] LOOP
      UPDATE OR INSERT INTO S VALUES (:i, :multiple * ((:i * (:i + 1)) / 2));  -- sum of multiples
END LOOP
RETURN s;
*/
END

*/
BEGIN
/*
  RDB$TRACE_MSG (
    'Sum of the first ' || [-unconvertible RS-245838 CAST(:n)] || ' multiples of ' ||
    [-unconvertible RS-245838 CAST(:m)] || ' is ' || [-unconvertible RS-245838 CAST(get_sum_multiples (:m, :sn)(:n) AS VARCHAR(32765))]  -- calling from a function and getting the nth element
  , TRUE);
*/
END;
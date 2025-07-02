DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3, REVERSE 1..3 LOOP
    FOR n IN 1..3, REVERSE 1..3 LOOP
      summa := summa + i*n;    -- 144 oracle version 23
    END LOOP;
  END LOOP;
END; 
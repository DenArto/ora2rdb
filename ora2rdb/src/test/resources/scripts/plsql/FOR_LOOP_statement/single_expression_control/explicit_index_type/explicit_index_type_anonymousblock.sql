DECLARE
  summa NUMBER(5,1) := 0;
BEGIN
  FOR n NUMBER(5,1) IN 1.0
  LOOP
      summa := summa + n; 
  END LOOP;
END; 
DECLARE
  summa PLS_INTEGER := 0;
BEGIN
  <<forlabel>>
  FOR i IN REVERSE 1..3
  LOOP
      summa := summa + forlabel.i; 
  END LOOP forlabel;
END; 
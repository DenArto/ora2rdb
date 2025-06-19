CREATE PROCEDURE P_Grade_meaning2 (degree INTEGER)
IS
  pass BOOLEAN := FALSE;
  res CHAR;
BEGIN
    res := '';
    IF degree > 10 THEN
      res := 'Good';
      pass := TRUE;
    ELSE 
      res := 'Low';
      pass := FALSE;
    END IF;
END; 
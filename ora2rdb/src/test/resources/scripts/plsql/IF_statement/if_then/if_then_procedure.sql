CREATE PROCEDURE P_Grade_meaning1 (degree INTEGER)
IS
  pass BOOLEAN := FALSE;
  res CHAR;
BEGIN
    res := '';
    IF degree >= 10 THEN
      res := 'Good';
      pass := TRUE;
    END IF;
    IF (degree < 10) AND (degree >=5) THEN
      res := 'Low';
      pass := FALSE;
    END IF;
    IF (degree < 5) THEN
      res := 'Too low';
    END IF;
END; 

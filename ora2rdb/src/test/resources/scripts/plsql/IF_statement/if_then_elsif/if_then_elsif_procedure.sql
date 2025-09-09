CREATE PROCEDURE P_Grade_meaning3(grade CHAR)
IS
  pass BOOLEAN := FALSE;
  res CHAR;
BEGIN
    res := '';
    IF grade = 'A' THEN
      res := 'Excellent';
      pass := TRUE;
    ELSIF grade = 'B' THEN
      res := 'Very Good';
      pass := TRUE;
    ELSIF grade = 'C' THEN
      res := 'Good';
      pass := TRUE;
    ELSIF grade = 'D' THEN
      res := 'Fair';
      pass := FALSE;
    ELSIF grade = 'F' THEN
      res := 'Poor';
      pass := FALSE;
    END IF;
END; 
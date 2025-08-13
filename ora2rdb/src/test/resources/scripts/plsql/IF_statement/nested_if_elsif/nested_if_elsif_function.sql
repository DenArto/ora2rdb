CREATE FUNCTION P_Grade_meaning7 (score NUMERIC, subject VARCHAR2)
RETURN VARCHAR2
IS
  pass BOOLEAN := TRUE;
  res  CHAR(15) := '';
BEGIN
    IF score > 50 THEN
        IF subject = 'Mathematics' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Physics' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Computer Science' THEN
            res := 'Good';
            pass := TRUE;
        END IF;
    ELSE
        IF subject = 'Mathematics' THEN
            res := 'Poor';
            pass := FALSE;
        ELSIF subject = 'Physics' THEN
            res := 'Poor';
            pass := FALSE;
        END IF;
    END IF;
    RETURN res;
END; 
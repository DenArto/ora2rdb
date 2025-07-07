CREATE FUNCTION F_Open_With_Param
RETURN VARCHAR2
IS
  cursor c1 (n NUMBER DEFAULT 10, m VARCHAR2 DEFAULT 'OK') 
    IS SELECT id FROM test_table 
       WHERE num < n AND res = m;
BEGIN
  OPEN c1;
  CLOSE c1;
  OPEN c1(m=>'POOR', n=>5);
  CLOSE c1;
  OPEN c1(2, 'POOR');
  CLOSE c1;
  OPEN c1(3);
  CLOSE c1;
  RETURN '';
END;
EXECUTE BLOCK
AS
  DECLARE tmp INTEGER;
BEGIN
  tmp = ROW_COUNT;
  UPDATE employees SET SALARY = SALARY * 1.1 WHERE SALARY <= 60000;
  tmp = ROW_COUNT;
END;
EXECUTE BLOCK 
AS
  DECLARE done BOOLEAN = FALSE;
  DECLARE res  VARCHAR(50) = '';
BEGIN
  WHILE (:done) DO
  BEGIN
    res = 'This line does not print.';
  END
  WHILE (NOT :done) DO 
  BEGIN
    done = TRUE;
    res = 'Hello, world!';
  END
  WHILE (NOT :done) DO
  BEGIN
    res = 'This line does not print.';
  END
END;
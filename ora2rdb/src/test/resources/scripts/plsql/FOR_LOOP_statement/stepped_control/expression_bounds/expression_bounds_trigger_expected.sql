CREATE OR ALTER TRIGGER T_Expr_Bounds
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
   DECLARE power INTEGER;
*/
BEGIN
/*
  power = 7;
  [-unconvertible RS-238758 FOR :i IN :power+3..:power+5] 
  LOOP
      summa = :summa + :i;
      power = 10;
  END LOOP
*/
END;
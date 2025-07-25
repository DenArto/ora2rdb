
CREATE OR ALTER TRIGGER T_Grade_meaning1
  AFTER INSERT
  ON students
SQL SECURITY DEFINER
AS

     DECLARE I NUMERIC(34, 8);
BEGIN
    I = 0;
    WHILE (TRUE) DO BEGIN
        I = :I + 1;
        IF( (:I > 5) ) THEN 
        	LEAVE  ;
    END 
END ;
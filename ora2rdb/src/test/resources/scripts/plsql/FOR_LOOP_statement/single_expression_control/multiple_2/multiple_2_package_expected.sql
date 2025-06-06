CREATE OR ALTER PACKAGE Pack_Multiple2
AS BEGIN
   FUNCTION PF_Multiple2
   RETURNS INTEGER;
   PROCEDURE PP_Multiple2; 
END; 

RECREATE PACKAGE BODY Pack_Multiple2
AS BEGIN
   FUNCTION PF_Multiple2
   RETURNS INTEGER
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       IF (NOT (i_FOR1 < 3)) THEN                       
       BEGIN 
         i_FOR1 = i_FOR1 + 1; 
         CONTINUE;
       END
         summa = :summa + :i_FOR1;
         i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = i_FOR1;
       summa = :summa + i_FOR1;
       LEAVE;
     END
     RETURN summa;
   END

   PROCEDURE PP_Multiple2
   AS
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE bound_i_FOR1 INTEGER;
   BEGIN
     i_FOR1 = 1;
     bound_i_FOR1 = 3;
     WHILE (i_FOR1 <= bound_i_FOR1) DO
     BEGIN 
       IF (NOT (i_FOR1 < 3)) THEN                       
       BEGIN 
         i_FOR1 = i_FOR1 + 1; 
         CONTINUE;
       END
         summa = :summa + :i_FOR1;
         i_FOR1 = i_FOR1 + 1;
     END
     i_FOR1 = bound_i_FOR1;
     WHILE (1=1) DO
     BEGIN
       i_FOR1 = i_FOR1;
       summa = :summa + i_FOR1;
       LEAVE;
     END
   END
END; 
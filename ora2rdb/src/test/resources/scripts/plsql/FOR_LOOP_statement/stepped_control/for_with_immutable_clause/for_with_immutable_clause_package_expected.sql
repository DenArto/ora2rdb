


CREATE OR ALTER PACKAGE Pack_For_With_Immutable_Index

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_Immutable_Index
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_Immutable_Index;   
  END;



RECREATE   PACKAGE BODY Pack_For_With_Immutable_Index
AS BEGIN  
   FUNCTION PF_For_With_Immutable_Index
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 FOR i IMMUTABLE IN 1..3] LOOP
       summa = :summa + i;
     END LOOP
     RETURN summa;
   */
END   

   PROCEDURE PP_For_With_Immutable_Index
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 FOR i IMMUTABLE IN 1..3] LOOP
       summa = :summa + i;
     END LOOP
   */
END   
  END; 
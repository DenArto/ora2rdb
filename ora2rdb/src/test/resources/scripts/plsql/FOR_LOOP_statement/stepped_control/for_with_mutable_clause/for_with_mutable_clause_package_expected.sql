


CREATE OR ALTER PACKAGE Pack_For_With_Mutable_Index

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_Mutable_Index
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_Mutable_Index;   
  END;



RECREATE   PACKAGE BODY Pack_For_With_Mutable_Index
AS BEGIN  
   FUNCTION PF_For_With_Mutable_Index
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 FOR i MUTABLE IN 1..10] LOOP
       i = i+1;
       summa = :summa + i;
     END LOOP
     RETURN summa;  -- 30
   */
END   

   PROCEDURE PP_For_With_Mutable_Index
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 FOR i MUTABLE IN 1..10] LOOP
       i = i+1;
       summa = :summa + i;
     END LOOP
   */
END   
  END; 
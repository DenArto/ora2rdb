CREATE OR REPLACE PACKAGE Pack_Explicit_Index
AS 
   FUNCTION PF_Explicit_Index
   RETURN NUMBER;
   PROCEDURE PP_Explicit_Index; 
END; 


CREATE OR REPLACE PACKAGE BODY Pack_Explicit_Index
AS 
   FUNCTION PF_Explicit_Index
   RETURN NUMBER
   IS
     summa NUMBER(5,1) := 0;
   BEGIN
     FOR n NUMBER(5,1) IN 1.0 .. 3.0 BY 0.5 
     LOOP
       summa := summa + n;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_Explicit_Index
   IS
     summa NUMBER(5,1) := 0;
   BEGIN
     FOR n NUMBER(5,1) IN 1.0 .. 3.0 BY 0.5 
     LOOP
       summa := summa + n;
     END LOOP;
   END; 
END; 
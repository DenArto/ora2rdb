CREATE OR REPLACE PACKAGE Pack_For_With_While_and_When
AS 
   FUNCTION PF_For_With_While_and_When
   RETURN PLS_INTEGER;
   PROCEDURE PP_For_With_While_and_When; 
END; 

CREATE OR REPLACE PACKAGE BODY Pack_For_With_While_and_When
AS 
   FUNCTION PF_For_With_While_and_When
   RETURN PLS_INTEGER
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR power IN 2, REPEAT power*2 WHILE power <= 64 WHEN MOD(power, 32)= 0 
     LOOP
       summa := summa + power;
     END LOOP;
     RETURN summa;
   END;

   PROCEDURE PP_For_With_While_and_When
   IS
     summa PLS_INTEGER := 0;
   BEGIN
     FOR power IN 2, REPEAT power*2 WHILE power <= 64 WHEN MOD(power, 32)= 0 
     LOOP
       summa := summa + power;
     END LOOP;
   END; 
END; 
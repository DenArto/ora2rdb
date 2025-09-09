CREATE OR ALTER PACKAGE Pack_While
SQL SECURITY DEFINER
AS 
BEGIN 
   FUNCTION PF_While
   RETURNS VARCHAR(32765);  
   PROCEDURE PP_While;
END;

RECREATE PACKAGE BODY Pack_While
AS 
BEGIN 
   FUNCTION PF_While
   RETURNS VARCHAR(32765)
   AS
     DECLARE done BOOLEAN = FALSE;
     DECLARE res VARCHAR(50) = '';
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
     RETURN res;
   END  

   PROCEDURE PP_While
   AS
     DECLARE done BOOLEAN = FALSE;
     DECLARE res VARCHAR(50) = '';
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
   END
END;
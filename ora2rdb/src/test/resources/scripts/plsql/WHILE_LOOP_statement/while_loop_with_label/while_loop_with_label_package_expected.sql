CREATE OR ALTER PACKAGE Pack_While_Label
SQL SECURITY DEFINER
AS 
BEGIN 
   FUNCTION PF_While_Label
   RETURNS VARCHAR(32765);  
   PROCEDURE PP_While_Label;
END;

RECREATE PACKAGE BODY Pack_While_Label
AS 
BEGIN 
   FUNCTION PF_While_Label
   RETURNS VARCHAR(32765)
   AS
     DECLARE done BOOLEAN = FALSE;
     DECLARE res VARCHAR(50) = '';
   BEGIN
     loopA:
     WHILE (NOT :done) DO 
     BEGIN
       done = TRUE;
       res = 'Hello, world!';
     END
     RETURN res;
   END  

   PROCEDURE PP_While_Label
   AS
     DECLARE done BOOLEAN = FALSE;
     DECLARE res VARCHAR(50) = '';
   BEGIN
     loopA:
     WHILE (NOT :done) DO 
     BEGIN
       done = TRUE;
       res = 'Hello, world!';
     END
   END
END;
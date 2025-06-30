


CREATE OR ALTER PACKAGE Pack_Expr_Bounds

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Expr_Bounds
   RETURNS VARCHAR(100);  
   PROCEDURE PP_Expr_Bounds;   
  END;



RECREATE   PACKAGE BODY Pack_Expr_Bounds
AS BEGIN  
   FUNCTION PF_Expr_Bounds
   RETURNS VARCHAR(100)
   AS
/*
      DECLARE reslt INTEGER = 0; 
     [-unconvertible RS-239346 TYPE nested_typ IS TABLE OF VARCHAR(20);] 
     [-unconvertible RS-239346 nt1 nested_typ] = [-unconvertible RS-239380 nested_typ('альфа','бета','гамма')]; 
     [-unconvertible RS-239346 nt2 nested_typ] = [-unconvertible RS-239380 nested_typ('бета','гамма','альфа')];  
   */
BEGIN
/* 
     [-unconvertible RS-238745 FOR i IN INDICES OF [-unconvertible RS-239287 nt1 MULTISET UNION nt2]] 
     LOOP
       reslt = :reslt + i;
     END LOOP
     RETURN reslt;
   */
END  

   PROCEDURE PP_Expr_Bounds
   AS
/*
      DECLARE reslt INTEGER = 0; 
     [-unconvertible RS-239346 TYPE nested_typ IS TABLE OF VARCHAR(20);] 
     [-unconvertible RS-239346 nt1 nested_typ] = [-unconvertible RS-239380 nested_typ('альфа','бета','гамма')]; 
     [-unconvertible RS-239346 nt2 nested_typ] = [-unconvertible RS-239380 nested_typ('бета','гамма','альфа')];  
   */
BEGIN
/* 
     [-unconvertible RS-238745 FOR i IN INDICES OF [-unconvertible RS-239287 nt1 MULTISET UNION nt2]] 
     LOOP
      reslt = :reslt + i;
     END LOOP
   */
END   
  END; 
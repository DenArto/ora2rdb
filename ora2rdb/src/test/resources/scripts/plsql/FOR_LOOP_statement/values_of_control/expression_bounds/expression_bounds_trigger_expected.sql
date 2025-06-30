CREATE OR ALTER TRIGGER T_Expr_Bounds
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
     DECLARE reslt VARCHAR(100); 
    [-unconvertible RS-239346 TYPE nested_typ IS TABLE OF VARCHAR(20);] 
    [-unconvertible RS-239346 nt1 nested_typ] = [-unconvertible RS-239380 nested_typ('альфа','бета','гамма')]; 
    [-unconvertible RS-239346 nt2 nested_typ] = [-unconvertible RS-239380 nested_typ('бета','гамма','альфа')];  
*/
BEGIN
/* 
    [-unconvertible RS-238760 FOR i IN VALUES OF [-unconvertible RS-239287 nt1 MULTISET UNION nt2]] 
    LOOP
      reslt = :reslt || i;
    END LOOP
*/
END;
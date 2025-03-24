CREATE FUNCTION F_Expr_Bounds
RETURN varchar2(100)
IS
  reslt varchar2(100); 
  TYPE nested_typ IS TABLE OF varchar2(20); 
  nt1 nested_typ := nested_typ('альфа','бета','гамма'); 
  nt2 nested_typ := nested_typ('бета','гамма','альфа');  
BEGIN 
    FOR i IN VALUES OF nt1 MULTISET UNION nt2 
    LOOP
      reslt := reslt || i;
    END LOOP;
    RETURN reslt; 
END; 
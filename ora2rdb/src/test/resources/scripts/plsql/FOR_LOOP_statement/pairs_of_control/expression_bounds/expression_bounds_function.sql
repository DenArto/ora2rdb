CREATE FUNCTION F_Expr_Bounds
RETURN varchar2(100)
IS
  reslt PLS_INTEGER := 0; 
  TYPE nested_typ IS TABLE OF varchar2(20); 
  nt1 nested_typ := nested_typ('alpha','beta','gamma');
  nt2 nested_typ := nested_typ('beta','gamma','alpha');
BEGIN 
    FOR i, j IN PAIRS OF nt1 MULTISET UNION nt2 
    LOOP
      reslt := reslt + i;
    END LOOP;
    RETURN reslt; 
END; 
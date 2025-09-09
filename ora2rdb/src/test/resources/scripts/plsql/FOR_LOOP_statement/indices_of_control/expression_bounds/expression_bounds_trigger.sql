CREATE OR REPLACE TRIGGER T_Expr_Bounds
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
    reslt PLS_INTEGER := 0; 
    TYPE nested_typ IS TABLE OF varchar2(20); 
    nt1 nested_typ := nested_typ('alpha','beta','gamma');
    nt2 nested_typ := nested_typ('beta','gamma','alpha');
BEGIN 
    FOR i IN INDICES OF nt1 MULTISET UNION nt2 
    LOOP
      reslt := reslt + i;
    END LOOP;
END;
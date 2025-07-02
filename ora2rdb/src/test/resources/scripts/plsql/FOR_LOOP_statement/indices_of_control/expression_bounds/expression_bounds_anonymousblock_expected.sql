
EXECUTE BLOCK 
 AS 

/*
     DECLARE reslt INTEGER = 0; 
    [-unconvertible RS-239346 TYPE nested_typ IS TABLE OF VARCHAR(20);] 
    [-unconvertible RS-239346 nt1 nested_typ] = [-unconvertible RS-239380 nested_typ('alpha','beta','gamma')];
    [-unconvertible RS-239346 nt2 nested_typ] = [-unconvertible RS-239380 nested_typ('beta','gamma','alpha')];
*/
BEGIN
/* 
    [-unconvertible RS-238745 FOR i IN INDICES OF [-unconvertible RS-239287 nt1 MULTISET UNION nt2]] 
    LOOP
      reslt = :reslt + i;
  END LOOP
*/
END;
 
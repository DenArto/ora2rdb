
EXECUTE BLOCK
 AS

     DECLARE s  INTEGER = 0;
     DECLARE i  INTEGER = 0;
     DECLARE j  INTEGER;
BEGIN
outer_loop:
  WHILE (TRUE) DO BEGIN
    i = :i + 1;
    j = 0;
    inner_loop:
    WHILE (TRUE) DO BEGIN
        j = :j + 1;
        s = :s + :i * :j; -- Sum several products
        IF( (:j > 5) ) THEN
        	LEAVE inner_loop  ;
        IF( ((:i * :j) > 15) ) THEN
        	LEAVE outer_loop  ;
    END
  END
END;
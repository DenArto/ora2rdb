DECLARE
    s  PLS_INTEGER := 0;
    i  PLS_INTEGER := 0;
    j  PLS_INTEGER;
BEGIN
<<outer_loop>>
  LOOP
    i := i + 1;
    j := 0;
    <<inner_loop>>
    LOOP
        j := j + 1;
        s := s + i * j; -- Sum several products
        EXIT inner_loop WHEN (j > 5);
        EXIT outer_loop WHEN ((i * j) > 15);
    END LOOP inner_loop;
  END LOOP outer_loop;
END;
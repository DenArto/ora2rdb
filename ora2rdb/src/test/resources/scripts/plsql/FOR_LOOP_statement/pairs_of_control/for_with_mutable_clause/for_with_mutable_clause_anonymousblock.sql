DECLARE
   TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   vec intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34);
   summa PLS_INTEGER := 0;
BEGIN
   FOR i, j MUTABLE IN PAIRS OF vec LOOP
      j := 100;
      summa := summa + i;   
   END LOOP;
END;
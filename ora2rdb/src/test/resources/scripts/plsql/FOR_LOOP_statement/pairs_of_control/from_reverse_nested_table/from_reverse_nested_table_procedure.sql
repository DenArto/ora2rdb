CREATE PROCEDURE P_From_Nested_table
IS
  TYPE nesttabl_t IS TABLE OF VARCHAR2(15);
  vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita');
  summa PLS_INTEGER := 0;
BEGIN
   FOR i, j IN REVERSE PAIRS OF vec LOOP
      summa := summa + i;
   END LOOP;
END;
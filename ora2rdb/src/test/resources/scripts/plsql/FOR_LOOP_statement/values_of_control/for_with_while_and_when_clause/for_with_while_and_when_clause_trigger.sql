CREATE OR REPLACE TRIGGER T_For_With_While_and_When
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
BEGIN
  FOR i IN VALUES OF vec WHILE i != 'Juanita' WHEN i != 'Mary'
  LOOP
     summa := summa || i;
  END LOOP;
END;
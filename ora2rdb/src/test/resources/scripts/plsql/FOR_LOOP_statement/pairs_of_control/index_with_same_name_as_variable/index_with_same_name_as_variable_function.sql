CREATE FUNCTION F_Same_Name_Var
RETURN VARCHAR2(100)
IS
  TYPE varray_t IS VARRAY(4) OF VARCHAR2(15);
  vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita');
  summa VARCHAR2(100) := '';
  i VARCHAR2(15);
  j VARCHAR2(15);
BEGIN
  FOR i, j IN PAIRS OF vec LOOP
      summa := summa || j;
  END LOOP;
  i := 'Jon';
  j := 'Rose';
  summa := summa || i || j;
  RETURN summa; 
END; 
CREATE GLOBAL TEMPORARY TABLE VEC_P_From_Reverse_Varray (
    ID  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    VAL VARCHAR(15)
);

CREATE PROCEDURE P_From_Reverse_Varray
AS
  /* TYPE varray_t IS VARRAY(4) OF VARCHAR2(15); */
   /* vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita'); */
   DECLARE summa INTEGER = 0;
   DECLARE i_FOR1 INTEGER;
BEGIN
   INSERT INTO VEC_P_From_Reverse_Varray(VAL) VALUES ('John');
   INSERT INTO VEC_P_From_Reverse_Varray(VAL) VALUES ('Mary');
   INSERT INTO VEC_P_From_Reverse_Varray(VAL) VALUES ('Alberto');
   INSERT INTO VEC_P_From_Reverse_Varray(VAL) VALUES ('Juanita');
   FOR SELECT ID FROM VEC_P_From_Reverse_Varray
   ORDER BY ID DESC
   INTO :i_FOR1
   DO
   BEGIN
     summa = :summa + i_FOR1; 
   END
END;
CREATE GLOBAL TEMPORARY TABLE VEC_T_From_Reverse_Nested_table (
    ID  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    VAL VARCHAR(15)
);

CREATE OR ALTER TRIGGER T_From_Reverse_Nested_table
  AFTER INSERT 
  ON students
AS
   /* TYPE nesttabl_t IS TABLE OF VARCHAR2(15); */
   /* vec nesttabl_t := nesttabl_t('John', 'Mary', 'Alberto', 'Juanita'); */
   DECLARE summa VARCHAR(100) = '';
   DECLARE i_FOR1 VARCHAR(15);
BEGIN
   INSERT INTO VEC_T_From_Reverse_Nested_table(VAL) VALUES ('John');
   INSERT INTO VEC_T_From_Reverse_Nested_table(VAL) VALUES ('Mary');
   INSERT INTO VEC_T_From_Reverse_Nested_table(VAL) VALUES ('Alberto');
   INSERT INTO VEC_T_From_Reverse_Nested_table(VAL) VALUES ('Juanita');
   FOR SELECT VAL FROM VEC_T_From_Reverse_Nested_table
   ORDER BY ID DESC
   INTO :i_FOR1
   DO
   BEGIN
     summa = :summa || i_FOR1; 
   END
END;
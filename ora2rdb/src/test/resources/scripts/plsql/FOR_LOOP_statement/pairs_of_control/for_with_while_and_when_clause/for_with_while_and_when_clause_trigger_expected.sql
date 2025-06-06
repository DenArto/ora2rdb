CREATE GLOBAL TEMPORARY TABLE VEC_T_For_With_While_and_When (
    ID  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    VAL VARCHAR(15)
);

CREATE OR ALTER TRIGGER T_For_With_While_and_When
  AFTER INSERT 
  ON students
AS
   /* TYPE varray_t IS VARRAY(4) OF VARCHAR2(15); */
   /* vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita'); */
   DECLARE summa INTEGER = 0;
   DECLARE i_FOR1 INTEGER;
   DECLARE j_FOR1 VARCHAR(15);
BEGIN
   INSERT INTO VEC_T_For_With_While_and_When(VAL) VALUES ('John');
   INSERT INTO VEC_T_For_With_While_and_When(VAL) VALUES ('Mary');
   INSERT INTO VEC_T_For_With_While_and_When(VAL) VALUES ('Alberto');
   INSERT INTO VEC_T_For_With_While_and_When(VAL) VALUES ('Juanita');
   FOR SELECT ID, VAL FROM VEC_T_For_With_While_and_When
   ORDER BY ID ASC
   INTO :i_FOR1, :j_FOR1
   DO
   BEGIN
     IF (NOT(i_FOR1 != 4)) THEN LEAVE;
     IF (NOT(j_FOR1 != 'Mary')) THEN CONTINUE;
     summa = :summa + i_FOR1; 
   END
END;
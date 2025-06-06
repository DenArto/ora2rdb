CREATE GLOBAL TEMPORARY TABLE VEC1_AssArr_1 (
    K INTEGER,
    VAL INTEGER,
    CONSTRAINT PK_VEC1_AssArr_1 PRIMARY KEY (K)
);

CREATE GLOBAL TEMPORARY TABLE VEC2_Varray_1 (
    ID  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    VAL VARCHAR(15)
);

EXECUTE BLOCK 
AS
   /* TYPE intvec_t IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER; */
   /* vec1 intvec_t := intvec_t(3 => 10, 1 => 11, 100 => 34); */
   /* TYPE varray_t IS VARRAY(4) OF VARCHAR2(15); */
   /* vec2 varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita'); */
   DECLARE i_FOR1 INTEGER;
   DECLARE i_FOR2 INTEGER;
BEGIN
   UPDATE OR INSERT INTO VEC1_AssArr_1 VALUES (3, 10);
   UPDATE OR INSERT INTO VEC1_AssArr_1 VALUES (1, 11);
   UPDATE OR INSERT INTO VEC1_AssArr_1 VALUES (100, 34);
   INSERT INTO VEC2_Varray_1(VAL) VALUES ('John');
   INSERT INTO VEC2_Varray_1(VAL) VALUES ('Mary');
   INSERT INTO VEC2_Varray_1(VAL) VALUES ('Alberto');
   INSERT INTO VEC2_Varray_1(VAL) VALUES ('Juanita');
   FOR SELECT K FROM VEC1_AssArr_1
   ORDER BY K ASC
   INTO :i_FOR1
   DO
   BEGIN
   END
   FOR SELECT ID FROM VEC2_Varray_1
   ORDER BY ID ASC
   INTO :i_FOR2
   DO
   BEGIN
   END
END;
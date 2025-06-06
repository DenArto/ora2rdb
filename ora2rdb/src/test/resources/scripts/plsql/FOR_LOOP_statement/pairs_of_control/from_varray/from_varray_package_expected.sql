CREATE GLOBAL TEMPORARY TABLE VEC_Pack_From_Varray_PF_From_Varray (
    ID  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    VAL VARCHAR(15)
);

CREATE GLOBAL TEMPORARY TABLE VEC_Pack_From_Varray_PP_From_Varray (
    ID  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    VAL VARCHAR(15)
);

CREATE OR ALTER PACKAGE Pack_From_Varray
AS BEGIN
   FUNCTION PF_From_Varray
   RETURNS VARCHAR(100);
   PROCEDURE PP_From_Varray; 
END; 

RECREATE PACKAGE BODY Pack_From_Varray
AS BEGIN
   FUNCTION PF_From_Varray
   RETURNS VARCHAR(100)
   AS
     /* TYPE varray_t IS VARRAY(4) OF VARCHAR2(15); */
     /* vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita'); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE j_FOR1 VARCHAR(15);
   BEGIN
     INSERT INTO VEC_Pack_From_Varray_PF_From_Varray(VAL) VALUES ('John');
     INSERT INTO VEC_Pack_From_Varray_PF_From_Varray(VAL) VALUES ('Mary');
     INSERT INTO VEC_Pack_From_Varray_PF_From_Varray(VAL) VALUES ('Alberto');
     INSERT INTO VEC_Pack_From_Varray_PF_From_Varray(VAL) VALUES ('Juanita');
     FOR SELECT ID, VAL FROM VEC_Pack_From_Varray_PF_From_Varray
     ORDER BY ID ASC
     INTO :i_FOR1, :j_FOR1
     DO
     BEGIN
       summa = :summa + i_FOR1; 
     END
     RETURN summa;
   END

   PROCEDURE PP_From_Varray
   AS
     /* TYPE varray_t IS VARRAY(4) OF VARCHAR2(15); */
     /* vec varray_t := varray_t('John', 'Mary', 'Alberto', 'Juanita'); */
     DECLARE summa INTEGER = 0;
     DECLARE i_FOR1 INTEGER;
     DECLARE j_FOR1 VARCHAR(15);
   BEGIN
     INSERT INTO VEC_Pack_From_Varray_PP_From_Varray(VAL) VALUES ('John');
     INSERT INTO VEC_Pack_From_Varray_PP_From_Varray(VAL) VALUES ('Mary');
     INSERT INTO VEC_Pack_From_Varray_PP_From_Varray(VAL) VALUES ('Alberto');
     INSERT INTO VEC_Pack_From_Varray_PP_From_Varray(VAL) VALUES ('Juanita');
     FOR SELECT ID, VAL FROM VEC_Pack_From_Varray_PP_From_Varray
     ORDER BY ID ASC
     INTO :i_FOR1, :j_FOR1
     DO
     BEGIN
       summa = :summa + i_FOR1; 
     END
   END  
END;  
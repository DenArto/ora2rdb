CREATE OR REPLACE PROCEDURE CALL_P
AUTHID DEFINER
AS
    VALUE_OUT NUMBER;
    STMT VARCHAR2(50);
BEGIN
    VALUE_OUT := 0;
    STMT := 'BEGIN OUT_P(:A); END;';
    EXECUTE IMMEDIATE STMT USING IN VALUE_OUT;
END;
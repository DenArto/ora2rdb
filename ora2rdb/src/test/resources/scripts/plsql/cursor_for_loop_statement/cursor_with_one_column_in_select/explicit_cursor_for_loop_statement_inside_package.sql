CREATE OR REPLACE PACKAGE Pack_Grade_meaning1
AS
   FUNCTION PF_Grade_meaning1 (degree INTEGER)
   RETURN BOOLEAN;
   PROCEDURE PP_Grade_meaning1;
END Pack_Grade_meaning1;

CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning1
AS
   FUNCTION PF_Grade_meaning1 (degree INTEGER)
   RETURN BOOLEAN
   IS
     CURSOR C1 IS
        SELECT LAST_NAME FROM EMPLOYEES
        WHERE MANAGER_ID > 120
        ORDER BY LAST_NAME;
    BEGIN
        FOR ITEM IN C1
            LOOP
                NULL;
        END LOOP;
    RETURN TRUE;
    END;

   PROCEDURE PP_Grade_meaning1
    IS
        CURSOR C1 IS
            SELECT LAST_NAME FROM EMPLOYEES
            WHERE MANAGER_ID > 120
            ORDER BY LAST_NAME;
    BEGIN
        FOR ITEM IN C1
            LOOP
                NULL;
        END LOOP;
    END;
END Pack_Grade_meaning1;
CREATE TRIGGER COMP_TEST
FOR INSERT OR UPDATE OR DELETE ON EMP_TEST
    COMPOUND TRIGGER
    AFTER STATEMENT IS BEGIN
        NULL;
    END AFTER STATEMENT;
END;
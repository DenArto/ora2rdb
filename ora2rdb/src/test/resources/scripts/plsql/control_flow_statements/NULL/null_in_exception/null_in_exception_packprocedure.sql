CREATE PACKAGE PackP_Null_In_Exception
AS
    PROCEDURE PP_Null_In_Exception;
END;

CREATE PACKAGE BODY PackP_Null_In_Exception
AS
    PROCEDURE PP_Null_In_Exception
    IS
    BEGIN
      raise_application_error(-20134, 'Invalid number');
      EXCEPTION
        WHEN OTHERS THEN NULL;
    END;
END;
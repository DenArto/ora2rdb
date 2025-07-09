CREATE PACKAGE PackF_Null_In_Exception
AS
   FUNCTION PF_Null_In_Exception 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Null_In_Exception
AS
   FUNCTION PF_Null_In_Exception
   RETURN VARCHAR2
   IS
   BEGIN
     raise_application_error(-20134, 'Неправильный номер');
     RETURN '';
     EXCEPTION
       WHEN OTHERS THEN NULL;
   END;
END;
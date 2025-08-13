CREATE PROCEDURE P_Null_In_Exception
IS
BEGIN
  raise_application_error(-20134, 'Invalid number');
  EXCEPTION
    WHEN OTHERS THEN NULL;
END;
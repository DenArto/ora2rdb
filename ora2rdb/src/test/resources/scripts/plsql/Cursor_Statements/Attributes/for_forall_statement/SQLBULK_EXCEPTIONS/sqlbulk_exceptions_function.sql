CREATE FUNCTION F_Sqlbulk_Exceptions
RETURN VARCHAR2
IS
  bulk_errors EXCEPTION;
  PRAGMA EXCEPTION_INIT (bulk_errors, -24381);
  TYPE namelist_t IS TABLE OF VARCHAR2(32767);
  
  enames_with_errors namelist_t := namelist_t ('ABC', 'DEF', NULL,
                                               'LITTLE', RPAD ('BIGBIGGERBIGGEST', 250, 'ABC'),
                                               'SMITHIE');
BEGIN
  FORALL indx IN enames_with_errors.FIRST .. enames_with_errors.LAST SAVE EXCEPTIONS
    UPDATE EMPLOYEES SET last_name = enames_with_errors (indx);
  
  EXCEPTION
    WHEN bulk_errors
    THEN
      FOR indx IN 1 .. SQL%BULK_EXCEPTIONS.COUNT
      LOOP
        DBMS_OUTPUT.PUT_LINE ('Error '|| indx || ' occurred during ' || 'iteration ' || SQL%BULK_EXCEPTIONS (indx).ERROR_INDEX || ' updating name to '|| enames_with_errors (SQL%BULK_EXCEPTIONS (indx).ERROR_INDEX));
        DBMS_OUTPUT.PUT_LINE ('Oracle error is ' || SQLERRM ( -1 * SQL%BULK_EXCEPTIONS (indx).ERROR_CODE));
      END LOOP;
  RETURN '';
END;
CREATE PROCEDURE P_Sqlbulk_Exceptions
    SQL SECURITY DEFINER
 AS
/*
  bulk_errors EXCEPTION;
  [-unconvertible RS-239346 TYPE namelist_t IS TABLE OF VARCHAR(32767);]

  [-unconvertible RS-239346 enames_with_errors namelist_t] = [-unconvertible RS-239380 namelist_t ('ABC', 'DEF', NULL,
                                               'LITTLE', RPAD ('BIGBIGGERBIGGEST', 250, 'ABC'),
                                               'SMITHIE')];

  DECLARE VARIABLE indx INTEGER;
*/
BEGIN
/*
  [-unconvertible RS-240654 FORALL indx IN enames_with_errors.FIRST .. enames_with_errors.LAST SAVE EXCEPTIONS
    UPDATE EMPLOYEES SET last_name = enames_with_errors (indx)];

  /*EXCEPTION*/
    WHEN BULK_ERRORS
    DO
      BEGIN
	      indx = 1;
      WHILE ( indx <= SQL%BULK_EXCEPTIONS.COUNT) DO
      BEGIN
        RDB$TRACE_MSG ('Error '|| :indx || ' occurred during ' || 'iteration ' || SQL%BULK_EXCEPTIONS (:indx).ERROR_INDEX || ' updating name to '|| enames_with_errors (SQL%BULK_EXCEPTIONS (:indx).ERROR_INDEX), TRUE);
        RDB$TRACE_MSG ('Oracle error is ' || SQLERRM ( -1 * SQL%BULK_EXCEPTIONS (:indx).ERROR_CODE), TRUE);
      indx = indx + 1;
      END
      END
*/
END;
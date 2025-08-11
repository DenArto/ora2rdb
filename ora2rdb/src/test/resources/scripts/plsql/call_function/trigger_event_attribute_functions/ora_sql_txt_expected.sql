CREATE TRIGGER TRG_DDL
 AFTER ANY DDL STATEMENT
SQL SECURITY DEFINER
AS
/*
   DECLARE sql_text ora_name_list_t;
   DECLARE n INTEGER;
   DECLARE v_stmt VARCHAR(2000);
*/
BEGIN
/*
IF (RDB$GET_CONTEXT ('DDL_TRIGGER','EVENT_TYPE') = 'CREATE' OR RDB$GET_CONTEXT ('DDL_TRIGGER','EVENT_TYPE') = 'ALTER' OR RDB$GET_CONTEXT ('DDL_TRIGGER','EVENT_TYPE') = 'DROP') THEN
BEGIN
  n = [-unconvertible RS-245165 ora_sql_txt(:sql_text)];

  [-unconvertible RS-238758 FOR :i IN 1..:n] LOOP
    v_stmt = :v_stmt || :sql_text(:i);
  END LOOP

END
*/
END;
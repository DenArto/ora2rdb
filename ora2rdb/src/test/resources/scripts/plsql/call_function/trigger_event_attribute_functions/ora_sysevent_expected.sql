CREATE TRIGGER TRG_DDL
AFTER ANY DDL STATEMENT
SQL SECURITY DEFINER
AS
	DECLARE system_event VARCHAR(20);
BEGIN
	system_event = RDB$GET_CONTEXT ('DDL_TRIGGER','EVENT_TYPE');
END;
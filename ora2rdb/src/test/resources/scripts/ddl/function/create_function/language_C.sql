CREATE FUNCTION SHELL(CMD IN VARCHAR2)
RETURN PLS_INTEGER
AS
LANGUAGE C
LIBRARY EXTPROCSHELL_LIB
NAME "EXTPROCSHELL"
PARAMETERS (CMD STRING, RETURN INT);
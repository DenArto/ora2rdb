CREATE PACKAGE ACCESSIBLE_PACKAGE
ACCESSIBLE BY (hr_admin, FUNCTION func1, PROCEDURE proc1, PROCEDURE schema1.proc2)

IS

END ACCESSIBLE_PACKAGE;
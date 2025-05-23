CREATE FUNCTION tabcount (table_in IN VARCHAR2)
    RETURN PLS_INTEGER
IS
    l_query VARCHAR2 (32765) := 'SELECT COUNT(*) FROM ' || table_in;
    l_return PLS_INTEGER;
BEGIN
    EXECUTE IMMEDIATE l_query INTO l_return;
    RETURN l_return;
END;
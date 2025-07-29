CREATE FUNCTION tabcount (table_in  VARCHAR)
    RETURNS INTEGER
AS
    DECLARE l_query VARCHAR (32765) = 'SELECT COUNT(*) FROM ' || :table_in;
    DECLARE l_return INTEGER;
BEGIN
    EXECUTE STATEMENT (:l_query)  INTO :l_return;
    RETURN l_return;
END;
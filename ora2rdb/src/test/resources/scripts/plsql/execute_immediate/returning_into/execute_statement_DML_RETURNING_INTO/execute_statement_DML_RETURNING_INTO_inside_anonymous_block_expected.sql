
EXECUTE BLOCK
 AS

/*
     DECLARE sql_stmt           VARCHAR(200);
     DECLARE country_in         VARCHAR(50) = 'Russia';
     DECLARE currency_in        VARCHAR(20) = 'Ru';
     DECLARE returning_currency  VARCHAR(50);
     DECLARE returning_country VARCHAR(50);
*/
BEGIN
/*
    sql_stmt = 'INSERT INTO COUNTRY VALUES(:1, :2) RETURNING COUNTRY INTO :3';

    EXECUTE STATEMENT (:sql_stmt)
        [-unconvertible RS-245747 USING :country_in, :currency_in]
            [-unconvertible RS-245749 RETURNING INTO :returning_country];

    sql_stmt = NULL;
    sql_stmt = 'UPDATE COUNTRY SET CURRENCY = :1 WHERE COUNTRY = :2 RETURNING COUNTRY INTO :returning_country';

    EXECUTE STATEMENT (:sql_stmt)
        [-unconvertible RS-245747 USING :currency_in, :country_in]
        [-unconvertible RS-245749 RETURNING INTO :returning_country];

    sql_stmt = NULL;
    sql_stmt = 'DELETE FROM COUNTRY WHERE country = :1 returning currency into :2';

    EXECUTE STATEMENT (:sql_stmt)
    [-unconvertible RS-245747 USING :country_in]
    [-unconvertible RS-245749 RETURNING INTO :returning_currency];
*/
END;
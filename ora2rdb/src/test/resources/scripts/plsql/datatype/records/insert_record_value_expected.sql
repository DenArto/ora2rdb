EXECUTE BLOCK
    AS
    DECLARE VARIABLE DEPT_INFO TYPE OF TABLE COUNTRY;
BEGIN
	DEPT_INFO.COUNTRY = 'COUNTRY_NAME';
	DEPT_INFO.CURRENCY = 'COUNTRY_CURRENCY';
    INSERT INTO COUNTRY VALUES DEPT_INFO;
END;
/*Found error(s) in file while parsing
Error at line 3:23 - no viable alternative at input 'WITH\n    FUNCTION get_domain(url VARCHAR2) RETURN VARCHAR2 IS\n    pos BINARY_INTEGER;'
*/



/*
Error at line 3:23 - no viable alternative at input 'WITH\n    FUNCTION get_domain(url VARCHAR2) RETURN VARCHAR2 IS\n    pos BINARY_INTEGER;'
WITH
    FUNCTION get_domain(url VARCHAR2) RETURN VARCHAR2 IS
    pos BINARY_INTEGER;
*/
    len BINARY_INTEGER;
    
EXECUTE BLOCK 
 AS 
BEGIN
        pos = POSITION('www.', url);
        len = POSITION('.', SUBSTR(url,pos+4)) - 1;
        RETURN SUBSTRING(url FROM  pos + 4 FOR  len);
    END;
SELECT DISTINCT get_domain(catalog_url)
FROM product_information;
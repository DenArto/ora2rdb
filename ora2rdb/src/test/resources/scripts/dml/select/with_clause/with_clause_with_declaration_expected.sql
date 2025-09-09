WITH
    DECLARE FUNCTION get_domain(url VARCHAR) RETURNS VARCHAR(32765) AS
     DECLARE pos INTEGER;
     DECLARE len INTEGER;
    BEGIN
        pos = POSITION(url, 'www.');
        len = POSITION(SUBSTR(url,pos+4), '.') - 1;
        RETURN SUBSTRING(:url FROM  :pos + 4 FOR  :len);
    END
SELECT DISTINCT get_domain(catalog_url)
FROM product_information;
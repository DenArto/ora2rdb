CREATE GLOBAL TEMPORARY TABLE CITY_POPULATION (
    K VARCHAR(64),
    VAL NUMERIC(34, 8),
    CONSTRAINT PK_CITY_POPULATION PRIMARY KEY (K)
);

EXECUTE BLOCK
    AS

/*TYPE POPULATION IS TABLE OF NUMBER
    INDEX BY VARCHAR2(64);*/

    /*CITY_POPULATION  POPULATION;*/

BEGIN

END;

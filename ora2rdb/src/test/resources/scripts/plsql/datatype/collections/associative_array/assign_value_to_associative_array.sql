DECLARE

TYPE POPULATION IS TABLE OF NUMBER
    INDEX BY VARCHAR2(64);

    CITY_POPULATION  POPULATION;

BEGIN

    CITY_POPULATION('SMALLVILLE')  := 2000;
    CITY_POPULATION('MIDLAND')     := 750000;
    CITY_POPULATION('MEGALOPOLIS') := 1000000;

    CITY_POPULATION('SMALLVILLE') := 2001;

END;
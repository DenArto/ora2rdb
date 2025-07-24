DECLARE

    TYPE POPULATION IS TABLE OF NUMBER INDEX BY VARCHAR2(64);

    v_city  POPULATION;
    I  VARCHAR2(64);
    VAL NUMBER;

BEGIN
    VAL := v_city(I);
    I := v_city.LAST;
    I := v_city.FIRST;
    I := v_city.NEXT(I);
    I := v_city.COUNT();
    I := v_city.PRIOR('MIDLAND');
    bool_val := v_city.EXISTS('MIDLAND');
    v_city.DELETE('MIDLAND');
    v_city.DELETE('Columbus','San Diego' );
    v_city.DELETE();
END;
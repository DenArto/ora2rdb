CREATE GLOBAL TEMPORARY TABLE TEAM (
    ID  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    VAL VARCHAR(15)
);

EXECUTE BLOCK
    AS
    /*TYPE Foursome IS VARRAY(4) OF VARCHAR(15);*/

    /*team Foursome;*/
BEGIN
    /*team := Foursome('John', 'Mary', 'Alberto', 'Juanita');*/
    INSERT INTO TEAM(VAl) VALUES('John');
    INSERT INTO TEAM(VAl) VALUES('Mary');
    INSERT INTO TEAM(VAl) VALUES('Alberto');
    INSERT INTO TEAM(VAl) VALUES('Juanita');
END;
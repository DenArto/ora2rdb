CREATE GLOBAL TEMPORARY TABLE SALARIES (
    K VARCHAR(64),
    VAL NUMERIC(34, 8),
    CONSTRAINT PK_CITY_POPULATION PRIMARY KEY (K)
);

EXECUTE BLOCK
    AS
/*TYPE SalaryMap IS TABLE OF NUMBER INDEX BY VARCHAR2(100);*/

/*salaries SalaryMap := SalaryMap('John' => 50000, 'Alice' => 60000, 'Bob' => 55000);*/
BEGIN
UPDATE OR INSERT INTO CITY_POPULATION VALUES ('John', 50000);
UPDATE OR INSERT INTO CITY_POPULATION VALUES ('Alice', 60000);
UPDATE OR INSERT INTO CITY_POPULATION VALUES ('Bob', 55000);

END;
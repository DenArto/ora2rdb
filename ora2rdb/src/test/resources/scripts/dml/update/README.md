### [returning_clause.sql](returning_clause.sql)

    { RETURN | RETURNING } ( [ OLD | NEW ] expr [ , [ OLD | NEW ] expr ]... )
    INTO  data_item [ , data_item ]...

Согласно [статье](https://oracle-base.com/articles/23/dml-returning-clause-enhancements-23) 

RETURNING clause появился в версии 23ai. 
Однако на 21 версии возможно выполнить RETURNING , но не дает выполнить
RETURNING OLD/NEW value

-------------------------------------------------

### [error_log.sql](error_log.sql)

    LOG ERRORS
    [ INTO [schema.] table ]
    [ (simple_expression) ]
    [ REJECT LIMIT { integer | UNLIMITED } ]

создание таблицы вместе с LOG ERRORS table
https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/INSERT.html#GUID-903F8043-0254-4EE9-ACC1-CB8AC0AF3423__BCEGDJDJ:~:text=WHERE%20commission_pct%20%3E%200.25%3B-,Inserting%20Into%20a%20Table%20with%20Error%20Logging%3A%20Example,-The%20following%20statements
`CREATE TABLE raises (emp_id NUMBER, sal NUMBER
CONSTRAINT check_sal CHECK(sal > 8000));`

`EXECUTE DBMS_ERRLOG.CREATE_ERROR_LOG('raises', 'errlog');`

пример update with error logging
`UPDATE raises
SET emp_id = 100, sal = 8001
LOG ERRORS INTO errlog ('my_bad') REJECT LIMIT 10;`

----------------------------------------------

### [order_by_clause.sql](order_by_clause.sql)

    ORDER [ SIBLINGS ] BY
        { expr | position | c_alias }
        [ ASC | DESC ]
        [ NULLS FIRST | NULLS LAST ]
        [, { expr | position | c_alias }
        [ ASC | DESC ]
        [ NULLS FIRST | NULLS LAST ]
        ]...

Не удалось найти или самостоятельно составить пример с этим условием  
Не совсем понятно для чего его можно использовать


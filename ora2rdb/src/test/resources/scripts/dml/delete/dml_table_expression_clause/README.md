В тестах используются те же таблицы/представления/материализованные представления, 
что и в тестах на оперетор INSERT

### Синтаксис 

    { [ schema. ]
        { table
        [ partition_extension_clause
        | @ dblink
        ]
        | { view | materialized view } [ @ dblink ]
        }
        | ( subquery [ subquery_restriction_clause ] )
        | table_collection_expression
        }

----------------------------

### [delete_using_subquery_clause.sql](delete_using_subquery_clause.sql)

Такая команда удаляет все значения из таблицы BOOKS

**В РБД можно указать только таблицу или представление (явно) ,
а не ввиде подзапроса**

Предложение при конвертации - использовать представление

    CREATE VIEW view_name AS SELECT TITLE from books;
    DELETE FROM view_name;

Неоюходимо подумать над названием представления, и стоит ли его удалять сразу после выполнения оператора
delete
----------------------------

### [delete_from_materialized_view.sql](delete_from_materialized_view.sql)


/*При попытке удалить запись через материализованное представление выдает ошибку
delete from mv_books;
Error at Command Line : 6 Column : 13
Error report -
SQL Error: ORA-01732: обработка данных для данного предст.пользователя не разрешена
01732. 00000 -  "data manipulation operation not legal on this view"
       *Cause:
       *Action:*/
1733. 
----------------------------

### [delete_from__using_subquery_with_subquery.sql](delete_from__using_subquery_with_subquery.sql)

    delete from (SELECT
    B."TITLE" AS BOOK_TITLE
    FROM
    "HR"."BOOKS" B
    WHERE ISBN =
    (SELECT ISBN FROM READER WHERE FIRST_NAME = 'Ivan Ivanov'));

удаляет строку из таблицы BOOKS, ISBN которой совпадает с ISBN 
из таблицы READER, где имя читателя Ivan Ivanov

В РБД можно заменить представлением 

    CREATE VIEW view_name AS
    SELECT
    B."TITLE" AS BOOK_TITLE
    FROM
    "BOOKS" B
    WHERE ISBN =
    (SELECT ISBN FROM READER WHERE FIRST_NAME = 'Ivan Ivanov')

    DELETE FROM VIEW_NAME;

Работает аналогично. Стоит подумать над названием у представления и стоит ли его удалять после оператора delete

----------------------------

### [delete_from_with_subquery_restriction_clause.sql](delete_from_with_subquery_restriction_clause.sql)

Во время действия оператора delete в таблице не было книг, количество страниц 
которых превышает значение 400. Поэтому оператор не удалил ни одной строки

    select ISBN , TITLE, PAGE_COUNT from books;
    
        ISBN
    -------------
    TITLE
    --------------------------------------------------------------------------------
    PAGE_COUNT
    ----------
    9780596009205
    C++
    150
    
    9780134685991
    Python
    320
    
    ISBN
    -------------
    TITLE
    --------------------------------------------------------------------------------
    PAGE_COUNT
    ----------

В РБД можно заменить представлением 

    create or alter view view_name as
    SELECT "ISBN", "PAGE_COUNT"
    FROM "BOOKS"
    WHERE "PAGE_COUNT" > 400
    WITH CHECK OPTION;
    
    delete from view_name;

Работает аналогично

----------------------------
### CONSTRAINT 
 При попытке задать имя ограничению 

    delete from (
    SELECT "ISBN", "PAGE_COUNT"
    FROM "HR"."BOOKS"
    WHERE "PAGE_COUNT" > 400
    WITH CHECK OPTION constraint my_cnstr
    );

Oracle выдает ошибку

    Error at Command Line : 44 Column : 23
    Error report -
    SQL Error: ORA-00907: отсутствует правая скобка
    00907. 00000 -  "missing right parenthesis"
           *Cause:    
           *Action:

-----------------------------
### READ ONLY 

    delete from (
    SELECT "ISBN", "PAGE_COUNT"
    FROM "HR"."BOOKS"
    WHERE "PAGE_COUNT" > 400
    WITH READ ONLY
    );

Скрипт вызовет ошибку в Oracle

    Error at Command Line : 40 Column : 13
    Error report -
    SQL Error: ORA-42399: невозможно выполнить операцию DML для доступного только для чтения представления
    42399.0000 - "cannot perform a DML operation on a read-only view"


--------------------------------------------

### ключевое слово ONLY

**The ONLY clause** applies only to views. Specify ONLY syntax if the view in the UPDATE clause is a view that belongs to a hierarchy and you do not want to update rows from any of its subviews.

    DELETE [ hint ]
        [ FROM ]
    | ONLY (dml_table_expression_clause)


[Object View Hierarchies](https://docs.oracle.com/en/database/oracle/oracle-database/23/adobj/object-vew-hierarchies.html#GUID-02606831-2C41-4C51-8E18-36191EBDDD05)

--------------------------------------------


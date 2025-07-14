### [flashback_query_clause.sql](flashback_query_clause.sql)
Пример использования 

    SELECT salary FROM employees
    WHERE last_name = 'Chung';
    
        SALARY
    ----------
          3800
    
    UPDATE employees SET salary = 4000
    WHERE last_name = 'Chung';
    1 row updated.
    
    SELECT salary FROM employees
    WHERE last_name = 'Chung';
    
        SALARY
    ----------
          4000

    SELECT salary FROM employees
    AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '1' MINUTE)
    WHERE last_name = 'Chung';
    
        SALARY
    ----------
          3800

[ссылка](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/SELECT.html#GUID-CFA006CA-6FF1-4972-821E-6996142A51C6__I2112847:~:text=COUNT(*)*10%0A%2D%2D%2D%2D%2D%2D%2D%2D%2D%2D%2D%0A%20%20%20%20%20%20%20%20130-,Using%20Flashback%20Queries%3A%20Example,-The%20following%20statements) на пример из документации 

### [table_collection_expression.sql](table_collection_expression.sql)

В тесте TABLE(t1.people) берет столбец из вложенной таблицы и определеяет его как таблицу  

[ссылка](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/SELECT.html#GUID-CFA006CA-6FF1-4972-821E-6996142A51C6__I2065746:~:text=Clause%3A%20Example%22-,table_collection_expression,-The%20table_collection_expression%20lets) на документацию

### [pivot_clause.sql](pivot_clause.sql)

Позволяет преобразовывать строки в столбцы. Например для создания таблицы. 

В результате выполнения скрипта из теста, можно произвести выборку из новой таблицы 

    SELECT * FROM pivot_table ORDER BY year;

      YEAR      STORE   INTERNET
    ---------- ---------- ----------
      2004     5546.6
      2006   371895.5   100056.6
      2007  1274078.8  1271019.5
      2008   252108.3   393349.4

### [unpivot_clause.sql](unpivot_clause.sql)

Работает противоположно оператору pivot

[ссылка](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/SELECT.html#GUID-CFA006CA-6FF1-4972-821E-6996142A51C6__CHDFIIDD:~:text=where%2Dclause%20violation-,Using%20PIVOT%20and%20UNPIVOT%3A%20Examples,-The%20oe.orders) на пример из документации

### [row_pattern_clause.sql](row_pattern_clause.sql)

[документация](https://docs.oracle.com/en/database/oracle/oracle-database/21/dwhsg/sql-pattern-matching-data-warehouses.html#GUID-136DAC89-DA17-45C6-9E37-C9892723AC79:~:text=Index-,22%20SQL%20for%20Pattern%20Matching,-Recognizing%20patterns%20in)

[пример](https://docs.oracle.com/en/database/oracle/oracle-database/21/dwhsg/sql-pattern-matching-data-warehouses.html#GUID-E088DB07-41E8-4103-BEAE-7EC1448C5D69:~:text=Example%2022%2D1%20Pattern%20Match%3A%20Simple%20V%2DShape%20with%201%20Row%20Output%20per%20Match)

### [LATERAL_attribute.sql](LATERAL_attribute.sql)
Specify LATERAL to designate subquery as a lateral inline view. Within a lateral inline view, you can specify tables that appear to the left of the lateral inline view in the FROM clause of a query. You can specify this left correlation anywhere within subquery (such as the SELECT, FROM, and WHERE clauses) and at any nesting level.

[пример](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/SELECT.html#GUID-CFA006CA-6FF1-4972-821E-6996142A51C6__BABFDGIJ:~:text=Relations%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20204%20%20%20%20%20%20%20%20%20Baer-,Using%20Lateral%20Inline%20Views%3A%20Example,-The%20following%20example)


Нововведение ORACLE 23ai

**Проблема : на docker hub последняя версия 21** 
[Docker hub](https://hub.docker.com/r/gvenzl/oracle-xe)

### Синтаксис 

    { FROM | USING }
    { table_reference | join_clause | ( join_clause )  | inline_analytic_view  }
    [ , { table_reference | join_clause | ( join_clause) | inline_analytic_view  } ] ...

-----------------------------------------------------------------

### [from_using_clause_table.sql](from_using_clause_table.sql)

    UPDATE books b
    SET b.page_count = bpc.PAGE_COUNT
    FROM book_page_count bpс  WHERE b.ISBN = bpc.ISBN;

    UPDATE books b
    SET b.page_count = bpc.PAGE_COUNT
    USING book_page_count bpc
    WHERE b.ISBN = bpc.ISBN;

Примерный ожидаемый результат

    update books b
    set b.page_count = (select bpc.page_count  from book_page_count bpc
    WHERE b.ISBN = bpc.ISBN);

-----------------------------------------------------------------


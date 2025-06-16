## CALL

Оператор для вызова функции или процедуры из SQL.

```
    CALL { routine_clause | object_access_expression }
         [ INTO :host_variable
         [ [INDICATOR] :indicator_variable ] 
         ] ;

    routine_clause ::= [schema.] [type.|package.]{ function | procedure | method }
                       [ @dblink_name ] ( [ argument [, argument ]... ] )

    object_access_expression ::= { table_alias.column.
                                 | object_table_alias.
                                 | (expr).
                                 }
                                 { attribute [.attribute ]... [.method ([ argument [, argument ]... ]) ]
                                 | method ([ argument [, argument ]... ])
                                 }
```

<!--
CREATE OR REPLACE FUNCTION get_bonus(p_salary NUMBER, experience NUMBER)
RETURN NUMBER
IS
BEGIN
  RETURN 100;
END;

CREATE OR REPLACE PROCEDURE set_bonus(p_salary NUMBER, experience NUMBER)
IS
BEGIN
  NULL;
END;

CREATE OR REPLACE FUNCTION get_salary_bonus (
    p_salary IN OUT NUMBER,
    p_bonus OUT NUMBER )
RETURN NUMBER
IS
BEGIN
    RETURN 100;
END;

CREATE OR REPLACE PROCEDURE set_salary_bonus (
    p_salary IN OUT NUMBER,
    p_bonus OUT NUMBER )
IS
BEGIN
    NULL;
END;

CREATE OR REPLACE PACKAGE test_pack 
AS
  FUNCTION get_bonus(p_salary NUMBER, experience NUMBER)
  RETURN NUMBER;
  PROCEDURE set_salary_bonus (
        p_salary IN OUT NUMBER,
        p_bonus OUT NUMBER );  
END;

CREATE OR REPLACE PACKAGE BODY test_pack 
AS
  FUNCTION get_bonus(p_salary NUMBER, experience NUMBER)
    RETURN NUMBER
    IS
    BEGIN
        RETURN 100;
    END;
  PROCEDURE set_salary_bonus (
        p_salary IN OUT NUMBER,
        p_bonus OUT NUMBER )
    IS
    BEGIN
        NULL;
    END;  
END;

CREATE TYPE warehouse_typ3 AS OBJECT
    ( warehouse_id NUMBER(6),
      warehouse_name VARCHAR2(20),
      region_id NUMBER(6),    
      MEMBER FUNCTION ret_name
      RETURN VARCHAR2);

CREATE OR REPLACE TYPE BODY warehouse_typ3
      AS MEMBER FUNCTION ret_name
      RETURN VARCHAR2
      IS
         BEGIN
            RETURN self.warehouse_name;
         END;
      END;

CREATE OR REPLACE TYPE Employee_Type AS OBJECT (
  first_name   VARCHAR2(50),
  last_name    VARCHAR2(50),
  
  MEMBER FUNCTION get_full_name RETURN VARCHAR2
);
CREATE OR REPLACE TYPE BODY Employee_Type AS
  MEMBER FUNCTION get_full_name RETURN VARCHAR2 IS
  BEGIN
    RETURN first_name || ' ' || last_name;
  END;
END;
CREATE TABLE employees (
  id           NUMBER PRIMARY KEY,
  employee_obj Employee_Type
);
-->

# call_function_with_in_param

Рассматривается вызов функции только с IN параметрами. Аргументы могут быть позиционными, именованными или смешанного типа. Предложение INTO обязательно и требуется только при вызове функции. Вывод записывается в host-переменную.

В РБД из SQL функцию можно вызвать только оператором SELECT. Предложение INTO не конвертируется.

# call_function_with_inout_param

Рассматривается вызов функции с IN OUT и OUT параметрами. Предложение INTO обязательно и требуется только при вызове функции. Вывод записывается в host переменную. Параметры OUT и IN OUT должны соответствовать host переменным.

Функция с IN OUT и OUT параметрами конвертируется в процедуру с выходными параметрами. Для вызова процедуры в РБД также есть оператор CALL, но host переменные не конвертируются.
Предложение INTO не конвертируется.

# call_procedure_with_in_param

Рассматривается вызов процедуры только с IN параметрами. Аргументы могут быть позиционными, именованными или смешанного типа. 
Для вызова процедуры в РБД также есть оператор CALL.

# call_procedure_with_inout_param

Рассматривается вызов процедуры с IN OUT и OUT параметрами. Параметры OUT и IN OUT должны соответствовать host переменным.
Процедура с IN OUT и OUT параметрами конвертируется в процедуру с выходными параметрами. Для вызова процедуры в РБД также есть оператор CALL, но host переменные не конвертируются.

# call_pack_function

Вызов пакетной функции. Всё тоже самое, только добавляется название пакета. 

# call_pack_procedure

Вызов пакетной процедуры. Всё тоже самое, только добавляется название пакета. 

# call_type_method

Тестирование вызова метода объектного типа. 

# call_with_dblink

В системе распределенной базы данных @dblink - имя базы данных, содержащей автономную процедуру, или пакет, содержащую процедуру. Если вы опустите @dblink, то Oracle Database будет искать в вашей локальной базе данных.

# call_object_column

Не удалось придумать примеры

# call_object_table

Не удалось придумать примеры

# call_object_exp

Не удалось придумать примеры

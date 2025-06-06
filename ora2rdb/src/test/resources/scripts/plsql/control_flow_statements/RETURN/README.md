--------------------------------

Тестирование оператора перехода `RETURN` провоизводится для следующих типов PL/SQL объектов:

* Процедура
* Функция
* Пакетная процедура
* Пакетная функция
* Триггер DML
* Анонимный блок

Ключевое слово `RETURN` обычно ассоциируется с функциями, поскольку они должны возвращать значения. Однако PL/SQL позволяет использовать команду RETURN в процедурах, триггерах, анонимных блоках.  Версия этой команды не принимает выражений и не может
возвращать значения в вызывающий программный модуль — она просто прекращает выполнение программы и возвращает управление вызывающему коду.

Рассмотрим синтаксис оператора `RETURN`:

```sql
   RETURN;
```

В РБД существует аналогичный оператор - `EXIT`, который позволяет завершить выполнение программы.

```sql
   EXIT;
```

--------------------------------

### return_stat

Тестирование простого случая оператора `RETURN`.

--------------------------------


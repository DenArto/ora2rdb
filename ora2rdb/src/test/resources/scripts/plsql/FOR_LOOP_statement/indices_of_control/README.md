--------------------------------

Тестирование оператора `FOR` для диапазона значений провоизводится для следующих типов PL/SQL объектов:

* Процедура
* Функция
* Пакет (подпроцедура и подфункция)
* Триггер DML
* Анонимный блок

В Oracle/PLSQL цикл `FOR LOOP` может проходить по *ключам* коллекций (это касается асс массивов, вложенных таблиц и varray).


```sql
  [<< <метка> >>]
  FOR <имя итератора> [IMMUTABLE] [<тип данных итератора>]
  IN [REVERSE] INDICES OF <коллекция>`
  [WHILE <условие_остановки>] [WHEN <условие_пропуска>]
  LOOP
     <группа_операторов>
  END LOOP [<метка>];
```

В РБД нет коллекций и соответственно синтаксиса FOR для прохода по ним тоже нет. Но так как коллекции конвертируются в GTT, то цикл FOR можно заменить на FOR SELECT из GTT таблицы:

```sql
  DECLARE <имя итератора> {<тип элемента в коллекции>|[<тип данных итератора>]};
  ...
  [<метка>:]
  FOR SELECT ID FROM <GTT-таблица> 
  ORDER BY id {DESC | ASC}
  INTO :<имя итератора>
  DO
  BEGIN
    [ IF (<условие_остановки>) THEN LEAVE; ]
    [ IF (<условие_пропуска>) THEN CONTINUE; ]
    <группа_операторов>
  END
```

Чтобы `<имя итератора>` не пересекалось с именами других итераторов(границ) или с именем локальной переменной, в имя лучше добавить суффикс (причем со счетчиком, потому что мб несколько операторов FOR). В тестах этот суффикс будет "_for1", "_for2" и т.д.

*Замечание:* по какой то неизвестной причине (внутренней ошибке Оракла) проход по коллекциям циклом FOR таким способом внутри процедур, функций и т.д., т.е. везде кроме анонимного блока, не работает. Задавала вопрос на stackoverflow.com (пока ответа нет).

--------------------------------

### explicit_index_type.sql

Тип индекса указан явно. По умолчанию итеранд имеет такой же тип как ключ коллекции.

--------------------------------

### expression_bounds.sql

Коллекции внутри FOR могут быть заданы не просто именем, а выражением. Например, `nt1 MULTISET UNION nt2` (объединение коллекций). Соответственно такое выражение перед циклом нужно сначала вычислить.

--------------------------------

### few_fors.sql

Рассматривается два цикла for идущих друг за другом с одним и тем же именем итератора. Проверка на корректность имени итератора.

--------------------------------

### for_with_immutable_clause.sql

Для итеранда существуют свойства `MUTABLE` или `IMMUTABLE`. По умолчанию для итеранда состояние IMMUTABLE (за исключением цикла по курсорам), что означает, что внутри цикла нельзя менять значение самого итеранда. Иначе возникнет ошибка:
```
PLS-00363: выражение 'I' не м.б. использовано как адресат назначения
```
Ключевое слово `MUTABLE` не допускается для объекта итерации при использовании управления итерацией INDICES OF. 
Это свойство надо закомментировать.

---------------------------------------------------------

### for_with_when_skip_clause.sql

Задано условие пропуска цикла -- `WHEN`. Условие внутри `WHEN` проверяется в начале каждого цикла FOR. Если оно FALSE то цикл FOR переходит к следующей итерации.

--------------------------------

### for_with_while_and_when_clause.sql

Заданы оба условия -- `WHILE` и `WHEN`.

--------------------------------

### for_with_while_stop_clause.sql

Задано условие выхода из цикла -- `WHILE`. Условие внутри WHILE проверяется в начале каждого цикла FOR. Как только становится FALSE то происходит выход из цикла FOR.

--------------------------------


### from_assoc_array.sql

Простой случай, где цикл проходит по ключам ассоциативного массива.

--------------------------------

### from_nested_table.sql

Простой случай, где цикл проходит по ключам вложенной таблицы.

--------------------------------

### from_varray.sql

Простой случай, где цикл проходит по ключам коллекции VARRAY.


--------------------------------

### index_with_label.sql

Перед циклом может быть задана метка. Можно обратиться к индексу, указав перед ним метку цикла.

--------------------------------


### index_with_same_name_as_variable.sql

Объявлена переменная с таким же именем как и итератор. Это поверка что имя итератора имеет отличное имя.

--------------------------------

### multiple.sql

Перечислена через запятую цепочка коллекций, по ключам которых нужно пройтись

----------------------------------------

### nested_fors.sql

Вложенный один в другой `FOR`.

--------------------------------

### reverse_from_assoc_array.sql

Простой случай, где цикл проходит по ключам ассоциативного массива в обратном порядке.

--------------------------------

### reverse_from_nested_table.sql

Простой случай, где цикл проходит по ключам вложенной таблицы в обратном порядке.

--------------------------------

### reverse_from_varray.sql

Простой случай, где цикл проходит по ключам коллекции VARRAY в обратном порядке.

--------------------------------


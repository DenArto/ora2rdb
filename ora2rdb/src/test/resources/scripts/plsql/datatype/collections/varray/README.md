## Varrays 
### Описание
В Oracle PL/SQL Varray (массив с переменным размером) - это массив, число элементов которого может варьироваться от нуля (пусто) до объявленного максимального размера.
Чтобы получить доступ к элементу переменной Varray, используйте синтаксис variable_name(index).
Нижняя граница index равна 1; верхняя граница - это текущее количество элементов.
Верхняя граница изменяется при добавлении или удалении элементов, но она не может превышать максимальный размер.
### Методы 
Описаны в тесте **methods_of_varray.sql**
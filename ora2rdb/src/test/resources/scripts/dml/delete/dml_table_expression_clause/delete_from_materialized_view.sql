/*При попытке удалить запись через материализованное представление выдает ошибку
delete from mv_books;
Error at Command Line : 6 Column : 13
Error report -
SQL Error: ORA-01732: обработка данных для данного предст.пользователя не разрешена
01732. 00000 -  "data manipulation operation not legal on this view"
*Cause:
*Action:*/
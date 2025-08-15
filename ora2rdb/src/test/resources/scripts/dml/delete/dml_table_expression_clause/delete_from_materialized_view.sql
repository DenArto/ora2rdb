/*When trying to delete a record through a materialized view, it gives an error
delete from mv_books;
Error at Command Line : 6 Column : 13
Error report -
SQL Error: ORA-01732: data manipulation operation not permitted on this view
01732. 00000 -  "data manipulation operation not legal on this view"
*Cause:
*Action:*/
/*Found error(s) in file while parsing
Error at line 2:16 - no viable alternative at input 'CREATE MATERIALIZED VIEW po_mv\nREFRESH FAST ON STATEMENT'
*/


/*
Error at line 2:16 - no viable alternative at input 'CREATE MATERIALIZED VIEW po_mv\nREFRESH FAST ON STATEMENT'
CREATE MATERIALIZED VIEW po_mv
REFRESH FAST ON STATEMENT WITH ROWID
AS
SELECT o.rowid AS id, v.*
FROM purchase_order o,
     JSON_TABLE(o.c FORMAT json, '$' error on error null on empty
           COLUMNS
           (
             poNum varchar2(10) PATH '$.poNum',
             poDate varchar2(12) PATH '$.poDate',
           NESTED PATH '$.items[*]'
            COLUMNS
            (
             item_seq for ordinality,
             itemName varchar2(10) PATH '$.itemName',
             itemPrice number PATH '$.itemPrice',
             itemQuantity varchar2(10) PATH '$.itemQuantity'
            )
       )
     ) v;
*/

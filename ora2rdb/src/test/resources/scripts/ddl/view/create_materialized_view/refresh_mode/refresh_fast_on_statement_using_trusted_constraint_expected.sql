/*Found error(s) in file while parsing
Error at line 2:16 - no viable alternative at input 'CREATE MATERIALIZED VIEW sales_mv_onstat\nREFRESH FAST ON STATEMENT'
*/


/*
Error at line 2:16 - no viable alternative at input 'CREATE MATERIALIZED VIEW sales_mv_onstat\nREFRESH FAST ON STATEMENT'
CREATE MATERIALIZED VIEW sales_mv_onstat
REFRESH FAST ON STATEMENT USING TRUSTED CONSTRAINT
AS
SELECT s.rowid sales_rid, c.cust_first_name first_name, c.cust_last_name last_name,
       p.prod_name prod_name,
       s.quantity_sold quantity_sold, s.amount_sold amount_sold
FROM sh.sales s, sh.customers c, sh.products p
WHERE s.cust_id = c.cust_id and s.prod_id = p.prod_id;
*/

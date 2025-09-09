-- pay attention to the SELECT order during conversion
/*INSERT [-unconvertible RS-241760 ALL
   WHEN ottl <= 100000 THEN
      INTO small_orders
         VALUES(oid, ottl, sid, cid)
   WHEN ottl > 100000 and ottl <= 200000 THEN
      INTO medium_orders
         VALUES(oid, ottl, sid, cid)]
SELECT o.order_id oid, o.customer_id cid, o.order_total ottl,
       o.sales_rep_id sid, c.credit_limit cl, c.cust_email cem
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;*/
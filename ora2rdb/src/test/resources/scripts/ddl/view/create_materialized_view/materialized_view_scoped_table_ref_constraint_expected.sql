/*[-unconvertible RS-241931 CREATE MATERIALIZED VIEW customers_with_ref_mv
   (SCOPE FOR (cust_address) IS oe.cust_address_objtab_mv)   -- доделать грамматику
   AS SELECT * FROM customers_with_ref@orc1.example.com;]*/
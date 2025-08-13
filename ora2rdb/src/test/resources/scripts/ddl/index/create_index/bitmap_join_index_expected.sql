/*[-unconvertible RS-246430 CREATE BITMAP INDEX cust_sales_bji
ON    sales(customers.state)
FROM  sales, customers
WHERE sales.cust_id = customers.cust_id;]*/
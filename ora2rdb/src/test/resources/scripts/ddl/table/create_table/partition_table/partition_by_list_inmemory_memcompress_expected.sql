/*Found error(s) in file while parsing
Error at line 11:34 - no viable alternative at input 'CREATE TABLE list_customers\n   ( customer_id             NUMBER(6)\n   , nls_territory           VARCHAR2(30)\n   , cust_email              VARCHAR2(40))\n   PARTITION BY LIST (nls_territory) (\n   PARTITION asia VALUES ('CHINA', 'THAILAND')\n         INMEMORY MEMCOMPRESS FOR CAPACITY HIGH,\n   PARTITION europe VALUES ('GERMANY', 'ITALY', 'SWITZERLAND')\n         INMEMORY MEMCOMPRESS FOR CAPACITY LOW,\n   PARTITION rest VALUES (DEFAULT);'
*/



/*
Error at line 11:34 - no viable alternative at input 'CREATE TABLE list_customers\n   ( customer_id             NUMBER(6)\n   , nls_territory           VARCHAR2(30)\n   , cust_email              VARCHAR2(40))\n   PARTITION BY LIST (nls_territory) (\n   PARTITION asia VALUES ('CHINA', 'THAILAND')\n         INMEMORY MEMCOMPRESS FOR CAPACITY HIGH,\n   PARTITION europe VALUES ('GERMANY', 'ITALY', 'SWITZERLAND')\n         INMEMORY MEMCOMPRESS FOR CAPACITY LOW,\n   PARTITION rest VALUES (DEFAULT);'
-- RS-243163
CREATE TABLE list_customers
   ( customer_id             NUMBER(6)
   , nls_territory           VARCHAR2(30)
   , cust_email              VARCHAR2(40))
   PARTITION BY LIST (nls_territory) (
   PARTITION asia VALUES ('CHINA', 'THAILAND')
         INMEMORY MEMCOMPRESS FOR CAPACITY HIGH,
   PARTITION europe VALUES ('GERMANY', 'ITALY', 'SWITZERLAND')
         INMEMORY MEMCOMPRESS FOR CAPACITY LOW,
   PARTITION rest VALUES (DEFAULT);
*/
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

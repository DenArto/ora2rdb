INSERT ALL
   WHEN ORDER_TOTAL <= 100000 THEN
      INTO SMALL_ORDERS
   WHEN ORDER_TOTAL > 100000 AND ORDER_TOTAL <= 200000 THEN
      INTO MEDIUM_ORDERS
   WHEN ORDER_TOTAL > 200000 THEN
      INTO LARGE_ORDERS
SELECT ORDER_ID, ORDER_TOTAL, SALES_REP_ID, CUSTOMER_ID
FROM ORDERS;
VARIABLE x VARCHAR2(25);

CALL warehouse_typ3(456, 'Warehouse 456', 2236).ret_name()
   INTO :x;
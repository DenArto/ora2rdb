SELECT * FROM pivot_table UNPIVOT (yearly_total FOR order_mode IN (store AS 'direct',
           internet AS 'online'))
    ORDER BY year, order_mode;
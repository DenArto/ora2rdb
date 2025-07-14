/*SELECT * FROM pivot_table [-unconvertible RS-241384 UNPIVOT (yearly_total FOR order_mode IN (store AS 'direct',
           internet AS 'online'))]
    ORDER BY year ASC NULLS LAST, order_mode ASC NULLS LAST;*/
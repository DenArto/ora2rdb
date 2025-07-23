/*CREATE TABLE order_items
    ( order_id           NUMERIC(12) NOT NULL,
      line_item_id       NUMERIC(3)  NOT NULL,
      product_id         NUMERIC(6)  NOT NULL,
      unit_price         NUMERIC(8,2),
      quantity           NUMERIC(8),
      CONSTRAINT order_items_fk
      FOREIGN KEY(order_id) REFERENCES orders(order_id)
    )
    [-unconvertible RS-243394 PARTITION BY REFERENCE(order_items_fk)];*/
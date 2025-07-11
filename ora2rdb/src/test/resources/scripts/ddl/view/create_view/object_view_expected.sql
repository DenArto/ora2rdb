/* This type of view is not supported */
/*CREATE VIEW oc_inventories [-unconvertible RS-241921 OF inventory_typ
 WITH OBJECT ID (product_id)]
 AS SELECT i.product_id,
           warehouse_typ(w.warehouse_id, w.warehouse_name, w.location_id),
           i.quantity_on_hand
    FROM inventories i, warehouses w
    WHERE i.warehouse_id=w.warehouse_id;*/
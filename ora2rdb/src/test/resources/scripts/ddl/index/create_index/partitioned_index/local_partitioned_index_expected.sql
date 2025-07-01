CREATE INDEX product_bm_ix
    ON hash_products(list_price) IN TABLESPACE PRIMARY;
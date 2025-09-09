/*Found error(s) in file while parsing
Error at line 10:22 - no viable alternative at input 'CREATE TABLE sales_by_region (item# INTEGER, qty INTEGER,\n             store_name VARCHAR(30), state_code VARCHAR(2),\n             sale_date DATE)\n     STORAGE(INITIAL 10K NEXT 20K) TABLESPACE tbs1\n     PARTITION BY LIST (state_code)\n     (\n     PARTITION region_east\n        VALUES ('MA','NY','CT','NH','ME','MD','VA','PA','NJ')\n        STORAGE (INITIAL 8M)\n        TABLESPACE tb2,'
*/

-- RS-243163

/*
Error at line 10:22 - no viable alternative at input 'CREATE TABLE sales_by_region (item# INTEGER, qty INTEGER,\n             store_name VARCHAR(30), state_code VARCHAR(2),\n             sale_date DATE)\n     STORAGE(INITIAL 10K NEXT 20K) TABLESPACE tbs1\n     PARTITION BY LIST (state_code)\n     (\n     PARTITION region_east\n        VALUES ('MA','NY','CT','NH','ME','MD','VA','PA','NJ')\n        STORAGE (INITIAL 8M)\n        TABLESPACE tb2,'
CREATE TABLE sales_by_region (item# INTEGER, qty INTEGER,
             store_name VARCHAR(30), state_code VARCHAR(2),
             sale_date DATE)
     STORAGE(INITIAL 10K NEXT 20K) TABLESPACE tbs1
     PARTITION BY LIST (state_code)
     (
     PARTITION region_east
        VALUES ('MA','NY','CT','NH','ME','MD','VA','PA','NJ')
        STORAGE (INITIAL 8M)
        TABLESPACE tb2,
     PARTITION region_west
        VALUES ('CA','AZ','NM','OR','WA','UT','NV','CO')
        NOLOGGING,
     PARTITION region_south
        VALUES ('TX','KY','TN','LA','MS','AR','AL','GA'),
     PARTITION region_central
        VALUES ('OH','ND','SD','MO','IL','MI','IA'),
     PARTITION region_null
        VALUES (NULL),
     PARTITION region_unknown
        VALUES (DEFAULT)
     );
*/
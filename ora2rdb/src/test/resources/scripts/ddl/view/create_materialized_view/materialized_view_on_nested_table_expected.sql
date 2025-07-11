/*Found error(s) in file while parsing
Error at line 2:3 - no viable alternative at input 'CREATE MATERIALIZED VIEW oe.people_reltab_mv\n   NESTED'
*/


/*
Error at line 2:3 - no viable alternative at input 'CREATE MATERIALIZED VIEW oe.people_reltab_mv\n   NESTED'
CREATE MATERIALIZED VIEW oe.people_reltab_mv
   NESTED TABLE phones_ntab STORE AS phone_store_ntab_mv
   AS SELECT * FROM oe.people_reltab@orc1.example.com;
*/
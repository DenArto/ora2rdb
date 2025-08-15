/*Found error(s) in file while parsing
Error at line 14:1 - no viable alternative at input 'CREATE TABLE accounts\n( id             NUMBER\n , account_number NUMBER\n , customer_id    NUMBER\n , balance        NUMBER\n , branch_id      NUMBER\n , region         VARCHAR(2)\n , status         VARCHAR2(1)\n)\nPARTITION BY LIST (region)\nSUBPARTITION BY HASH (customer_id) SUBPARTITIONS 8\n( PARTITION p_northwest VALUES ('OR', 'WA')\n ,'
*/



/*
Error at line 14:1 - no viable alternative at input 'CREATE TABLE accounts\n( id             NUMBER\n , account_number NUMBER\n , customer_id    NUMBER\n , balance        NUMBER\n , branch_id      NUMBER\n , region         VARCHAR(2)\n , status         VARCHAR2(1)\n)\nPARTITION BY LIST (region)\nSUBPARTITION BY HASH (customer_id) SUBPARTITIONS 8\n( PARTITION p_northwest VALUES ('OR', 'WA')\n ,'
-- RS-243163
CREATE TABLE accounts
( id             NUMBER
 , account_number NUMBER
 , customer_id    NUMBER
 , balance        NUMBER
 , branch_id      NUMBER
 , region         VARCHAR(2)
 , status         VARCHAR2(1)
)
PARTITION BY LIST (region)
SUBPARTITION BY HASH (customer_id) SUBPARTITIONS 8
( PARTITION p_northwest VALUES ('OR', 'WA')
 , PARTITION p_southwest VALUES ('AZ', 'UT', 'NM')
 , PARTITION p_northeast VALUES ('NY', 'VM', 'NJ')
 , PARTITION p_southeast VALUES ('FL', 'GA')
 , PARTITION p_northcentral VALUES ('SD', 'WI')
 , PARTITION p_southcentral VALUES ('OK', 'TX')
);
*/
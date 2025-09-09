/*SELECT [-unconvertible RS-245294 LPAD ('Hello' , 12)] FROM RDB$DATABASE;*/
/*SELECT [-unconvertible RS-245294 LPAD ('World' , 12, ',')] FROM RDB$DATABASE;*/
/*SELECT [-unconvertible RS-245294 LPAD ('Hello' , 12, '')] FROM RDB$DATABASE;*/
/*SELECT [-unconvertible RS-245294 LPAD ('World' , 12, 'abc')] FROM RDB$DATABASE;*/
/*SELECT [-unconvertible RS-245294 LPAD ('Hello' , 12, 'abcdefghij')] FROM RDB$DATABASE;*/
/*SELECT [-unconvertible RS-245294 LPAD ('World' , 2)] FROM RDB$DATABASE;*/
/*SELECT [-unconvertible RS-245294 LPAD ('World' , 2, '')] FROM RDB$DATABASE;*/
/*SELECT [-unconvertible RS-245294 LPAD ('Hello' , 2, ',')] FROM RDB$DATABASE;*/
/*SELECT [-unconvertible RS-245294 LPAD ('World' , 0)] FROM RDB$DATABASE;*/
SELECT LPAD ('World' , -1) FROM RDB$DATABASE;
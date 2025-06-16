select LEAST('abs') from rdb$database;

select LEAST('abs', 435) from rdb$database;

select LEAST('abs', 'kfe') from rdb$database;

select LEAST(123, 435) from rdb$database;

select LEAST (1, '2.1', '.000832') from rdb$database;

select LEAST('HARRY','HARRIOT','HAROLD') from rdb$database;
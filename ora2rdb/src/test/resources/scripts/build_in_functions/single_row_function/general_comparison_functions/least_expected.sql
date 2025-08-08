select LEAST('abs') from RDB$DATABASE;

select LEAST('abs', 435) from RDB$DATABASE;

select LEAST('abs', 'kfe') from RDB$DATABASE;

select LEAST(123, 435) from RDB$DATABASE;

select LEAST (1, '2.1', '.000832') from RDB$DATABASE;

select LEAST('HARRY','HARRIOT','HAROLD') from RDB$DATABASE;
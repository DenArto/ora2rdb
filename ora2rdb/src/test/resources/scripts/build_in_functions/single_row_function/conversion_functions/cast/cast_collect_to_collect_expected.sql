/*[-unconvertible RS-239346 CREATE TYPE address_book_t AS TABLE OF cust_address_typ;]*/

/*[-unconvertible RS-239343 CREATE TYPE address_array_t AS VARRAY(3) OF cust_address_typ;]*/

CREATE TABLE states (state_id NUMERIC(34, 8), addresses address_array_t);

/*SELECT [-unconvertible RS-245838 CAST(s.addresses AS address_book_t)]
  FROM states s 
  WHERE s.state_id = 111;*/

/*
[-unconvertible CREATE TYPE address_book_t AS TABLE OF cust_address_typ;]
*/
/*
[-unconvertible CREATE TYPE address_array_t AS VARRAY(3) OF cust_address_typ;]
*/
/*
CREATE TABLE states (state_id NUMBER, [-unconvertible addresses address_array_t]);
*/
/*
SELECT [-unconvertible CAST(s.addresses AS address_book_t)]
  FROM states s 
  WHERE s.state_id = 111;
*/
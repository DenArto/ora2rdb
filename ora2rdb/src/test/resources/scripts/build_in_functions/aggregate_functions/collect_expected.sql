/*[-unconvertible CREATE TYPE phone_book_t AS TABLE OF phone_list_typ];*/

SELECT CAST([-unconvertible COLLECT(phone_numbers)] AS phone_book_t) "Income Level L Phone Book"
  FROM customers
  WHERE income_level = 'L: 300,000 and above';
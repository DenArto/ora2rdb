SELECT REGEXP_SUBSTR('500 Oracle Parkway, Redwood Shores, CA', ',[^,]+,') FROM DUAL;

SELECT REGEXP_SUBSTR('http://www.example.com/products', 'http://([[:alnum:]]+\.?){3,4}/?') FROM DUAL;

SELECT REGEXP_SUBSTR('1234567890', '(123)(4(56)(78))', 1, 1, 'i', 2) FROM DUAL;

SELECT REGEXP_SUBSTR('my email http://www.example.com/products', 'http://([[:alnum:]]+\.?){3,4}/?', 4) FROM DUAL;

SELECT REGEXP_SUBSTR('abcd1234efgh5678', '([[:alpha:]]+[0-9]+)',1,5, '', 1) FROM DUAL;
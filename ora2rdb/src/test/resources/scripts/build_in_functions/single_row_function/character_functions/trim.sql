SELECT TRIM('  Hello   ') FROM DUAL;
SELECT TRIM(LEADING FROM '  Hello   ') FROM DUAL;
SELECT TRIM(TRAILING FROM '  Hello   ') FROM DUAL;
SELECT TRIM(BOTH FROM '  Hello   ') FROM DUAL;
SELECT TRIM('*' FROM '**Hello*') FROM DUAL;
SELECT TRIM(LEADING '*' FROM '**Hello*') FROM DUAL;
SELECT TRIM(TRAILING '*' FROM '**Hello*') FROM DUAL;
SELECT TRIM(BOTH '*' FROM '**Hello*') FROM DUAL;
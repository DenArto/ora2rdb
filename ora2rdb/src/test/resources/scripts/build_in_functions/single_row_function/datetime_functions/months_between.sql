SELECT MONTHS_BETWEEN (TO_DATE('02-02-1995','MM-DD-YYYY'), TO_DATE('01-01-1995','MM-DD-YYYY') ) FROM DUAL;
SELECT MONTHS_BETWEEN (TO_DATE('03-31-1995','MM-DD-YYYY'), TO_DATE('04-10-1995','MM-DD-YYYY') ) FROM DUAL;
SELECT MONTHS_BETWEEN (TO_DATE('04-10-1996','MM-DD-YYYY'), TO_DATE('04-10-1995','MM-DD-YYYY') ) FROM DUAL;
SELECT MONTHS_BETWEEN (TO_DATE('04-04-2025','MM-DD-YYYY'), TO_DATE('10-31-1995','MM-DD-YYYY') ) FROM DUAL;
SELECT MONTHS_BETWEEN (TO_DATE('04-30-2025','MM-DD-YYYY'), TO_DATE('01-31-1995','MM-DD-YYYY') ) FROM DUAL;
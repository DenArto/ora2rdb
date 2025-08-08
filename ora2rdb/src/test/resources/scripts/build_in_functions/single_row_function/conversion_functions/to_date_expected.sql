/*SELECT [-unconvertible RS-245838 TO_DATE('2025-04-23', 'YYYY-MM-DD')] FROM RDB$DATABASE;*/

/*SELECT [-unconvertible RS-245838 TO_DATE('February 15, 2016, 11:00 A.M.'
       [-unconvertible RS-245741 DEFAULT 'January 01, 2016 12:00 A.M.' ON CONVERSION ERROR],
       'Month dd, YYYY, HH:MI A.M.')] FROM RDB$DATABASE;*/

/*SELECT [-unconvertible RS-245838 TO_DATE('January 15, 1989, 11:00 A.M.',
    'Month dd, YYYY, HH:MI A.M.',
    'NLS_DATE_LANGUAGE = American')] FROM RDB$DATABASE;*/

/*SELECT [-unconvertible RS-245838 TO_DATE('January 15, 1989, 11:00 A.M.'
    [-unconvertible RS-245838 [-unconvertible RS-245741 DEFAULT 'January 01, 2016 12:00 A.M.' ON CONVERSION ERROR]],
    'Month dd, YYYY, HH:MI A.M.',
    'NLS_DATE_LANGUAGE = American')] FROM RDB$DATABASE;*/
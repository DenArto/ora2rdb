SELECT INSTR('CORPORATE FLOOR','OR', 3, 2) FROM DUAL;

SELECT INSTR('CORPORATE FLOOR','OR') FROM DUAL;

SELECT INSTR('CORPORATE FLOOR','IR') FROM DUAL;

SELECT INSTR('CORPORATE FLOOR','OR', 3) FROM DUAL;

SELECT INSTR('CORPORATE FLOOR','OR', 3, 20) FROM DUAL;

SELECT INSTR('CORPORATE FLOOR','OR', 30, 2) FROM DUAL;

SELECT INSTR('CORPORATE FLOOR','OR', -3) FROM DUAL;

SELECT INSTR('CORPORATE FLOOR','OR', -1) FROM DUAL;

SELECT INSTR('CORPORATE FLOOR','OR', -1, 2) FROM DUAL;

SELECT INSTR('CORPORATE FLOOR','OR', -1, 3) FROM DUAL;


SELECT INSTRB('CORPORATE FLOOR','OR', 3, 2) FROM DUAL;
SELECT INSTRC('CORPORATE FLOOR','OR', 3, 2) FROM DUAL;
SELECT INSTR2('CORPORATE FLOOR','OR', 3, 2) FROM DUAL;
SELECT INSTR4('CORPORATE FLOOR','OR', 3, 2) FROM DUAL;
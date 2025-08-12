


CREATE EXCEPTION PAST_DUE
	'PAST_DUE EXCEPTION';
CREATE EXCEPTION CUSTOM_EXCEPTION
	'error';
CREATE OR ALTER PACKAGE errnums
 SQL SECURITY DEFINER
AS BEGIN 
    PROCEDURE PP_Grade_meaning1;  
  END;



/*RECREATE   PACKAGE BODY errnums
AS BEGIN 
    --[-unconvertible RS-245963 past_due  EXCEPTION;]                         -- declare exception
  

    PROCEDURE PP_Grade_meaning1
    AS
    BEGIN
        EXCEPTION CUSTOM_EXCEPTION( 'Account past due.');
    END  
  END;*/
CREATE EXCEPTION CUSTOM_EXCEPTION
	'error';
CREATE EXCEPTION PAST_DUE
	'PAST_DUE EXCEPTION';


EXECUTE BLOCK
 AS

    --past_due  EXCEPTION;                       -- declare exception
  -- assign error code to exception
BEGIN
    EXCEPTION CUSTOM_EXCEPTION( 'Account past due.');
END;
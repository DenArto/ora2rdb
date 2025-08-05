CREATE FUNCTION CALLING_F
RETURNS VARCHAR(32765)

 SQL SECURITY DEFINER
 AS
     DECLARE out_value_from_function VARCHAR(50);
     DECLARE return_value_from_function VARCHAR(50);
BEGIN
    if (FUNCTION_NAME_WITH_IN_PARAMETER('in_value') = 'in_value') then
    BEGIN   -- inside IF-ELSE
        RETURN 'in_value';
    END
    RETURN 'empty';
END;
CREATE FUNCTION total_sales (company_id_in  NUMERIC(34, 8), status_in  VARCHAR)
RETURNS NUMERIC(34, 8)

 SQL SECURITY DEFINER
 AS
BEGIN
    RETURN 1;
END;


EXECUTE BLOCK
 AS

     DECLARE return_value NUMERIC(34, 8);
BEGIN
    return_value = total_sales(company_id_in => 1, status_in => 'N');

    return_value = total_sales(status_in => 'N', company_id_in => 1);
END;
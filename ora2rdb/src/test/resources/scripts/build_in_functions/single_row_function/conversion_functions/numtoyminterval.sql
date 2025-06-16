DECLARE
    an_interval INTERVAL YEAR TO MONTH;
BEGIN
    an_interval := NUMTOYMINTERVAL(1,'year');
END;
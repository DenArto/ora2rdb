DECLARE
    an_interval INTERVAL DAY TO SECOND;
BEGIN
    an_interval := NUMTODSINTERVAL (1440,'Minute');
END;
-- WARNING: THIS IS A ROW TRIGGER
CREATE TRIGGER TR_TURTLES_BUE
BEFORE INSERT
ON TURTLES
SQL SECURITY DEFINER
AS
BEGIN
    IF (NEW.NAME = 'СПЛИНТЕР' AND OLD.ESSENCE = 'КРЫСА' AND NEW.ESSENCE = 'СЭНСЭЙ') THEN BEGIN

    END

END;
CREATE TRIGGER TRG_DDL
AFTER CREATE OR ALTER OR DROP ON SCHEMA
DECLARE
    system_event VARCHAR2(20);
BEGIN
    system_event := ora_dict_obj_name;
END;
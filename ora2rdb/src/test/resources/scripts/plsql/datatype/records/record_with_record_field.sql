DECLARE
TYPE NAME_REC IS RECORD (
    FIRST  NUMBER,
    LAST   NUMBER
  );

  TYPE CONTACT IS RECORD (
    NAME  NAME_REC,
    FIELD VARCHAR2(100)
  );
  FRIEND CONTACT;
BEGIN
    NULL;
END;
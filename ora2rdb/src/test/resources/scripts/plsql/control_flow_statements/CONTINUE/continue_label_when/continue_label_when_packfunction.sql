CREATE PACKAGE PackF_Continue_Label_When
AS
   FUNCTION PF_Continue_Label_When 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Continue_Label_When
AS
   FUNCTION PF_Continue_Label_When
   RETURN VARCHAR2
   IS
     x NUMBER := 0;
   BEGIN
     <<while1>>
     WHILE (x != 5) LOOP
       x := x + 1;
       CONTINUE while1 WHEN x < 3;
     END LOOP;
     RETURN '';
   END;
END;
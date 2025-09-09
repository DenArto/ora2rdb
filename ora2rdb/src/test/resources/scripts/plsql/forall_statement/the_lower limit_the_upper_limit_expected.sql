CREATE TABLE hmo_coverage (
    denial VARCHAR(100),
    patient_name VARCHAR(100))


EXECUTE BLOCK
 AS

/*
    [-unconvertible RS-239346 TYPE denials_t IS TABLE OF TYPE OF COLUMN hmo_coverage.denial;]

    [-unconvertible RS-239346 TYPE patient_names_t IS TABLE OF TYPE OF COLUMN hmo_coverage.denial;]

   [-unconvertible RS-239346 l_denials denials_t]
                  = [-unconvertible RS-239380 denials_t ('TOO SICK', 'TOO POOR', 'COMPLAINS TOO MUCH')];
   [-unconvertible RS-239346 l_names patient_names_t]
                    = [-unconvertible RS-239380 patient_names_t ('John Lovecanal', 'Sally Works2Jobs')];
*/
BEGIN
/*
   [-unconvertible RS-240654 FORALL indx IN l_denials.FIRST .. l_denials.LAST
      INSERT INTO hmo_coverage
           VALUES (l_denials (indx), l_names (indx))];
*/
END;
/*[-unconvertible RS-247116 CREATE TABLE people_demo1 OF people_typ;]*/

/*[-unconvertible RS-247116 CREATE TABLE people_demo2 OF people_typ;]*/

/*[-unconvertible RS-247119 UPDATE people_demo1 p SET VALUE(p) =
                              (SELECT VALUE(q) FROM people_demo2 q
WHERE p.department_id = q.department_id)
WHERE p.department_id = 10];*/
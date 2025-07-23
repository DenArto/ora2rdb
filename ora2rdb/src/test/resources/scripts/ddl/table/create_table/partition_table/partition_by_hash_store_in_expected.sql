/*CREATE TABLE scubagear
     (id NUMERIC(34, 8),
      name VARCHAR (60))
   [-unconvertible RS-243394 PARTITION BY HASH (id)
   PARTITIONS 4
   STORE IN (gear1, gear2, gear3, gear4)];*/
SELECT id,
       code,
       bin_value,
       bit_xor_agg(bin_value) OVER (PARTITION BY code ORDER BY id
                      RANGE BETWEEN 1 PRECEDING AND 2 FOLLOWING) AS rows_avg
from   t1;

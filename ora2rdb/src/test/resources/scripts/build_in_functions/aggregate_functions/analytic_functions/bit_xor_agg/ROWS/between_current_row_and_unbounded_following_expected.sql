/*SELECT id,
       code,
       bin_value,
       [-unconvertible RS-244710 bit_xor_agg(bin_value)] OVER (PARTITION BY code ORDER BY id ASC NULLS LAST
                      ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS rows_avg
from   t1;*/
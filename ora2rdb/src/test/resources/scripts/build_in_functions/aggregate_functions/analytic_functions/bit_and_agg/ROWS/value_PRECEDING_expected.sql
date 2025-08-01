/*SELECT id,
       code,
       bin_value,
       [-unconvertible RS-244710 bit_and_agg(bin_value)] OVER (PARTITION BY code ORDER BY id ASC NULLS LAST
                      ROWS 1 PRECEDING) AS rows_avg
from   t1;*/
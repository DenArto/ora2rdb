/*SELECT id,
       code,
       bin_value,
       [-unconvertible RS-244710 bit_or_agg(bin_value)] OVER (PARTITION BY code ORDER BY id ASC NULLS LAST
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
from   t1;*/
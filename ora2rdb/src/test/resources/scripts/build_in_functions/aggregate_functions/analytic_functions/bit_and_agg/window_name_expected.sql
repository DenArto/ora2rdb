/*SELECT id,
       code,
       bin_value,
       [-unconvertible RS-244710 bit_and_agg(bin_value)] OVER w1  AS rows_avg
from   t1
window w1 as (PARTITION BY code ORDER BY id ASC NULLS LAST
                     RANGE 1 PRECEDING [-unconvertible RS-244675 EXCLUDE CURRENT ROW]);*/
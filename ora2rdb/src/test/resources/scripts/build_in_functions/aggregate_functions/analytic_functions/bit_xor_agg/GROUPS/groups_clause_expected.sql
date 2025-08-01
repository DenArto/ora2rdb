/*SELECT id,
       code,
       bin_value,
       [-unconvertible RS-244710 bit_xor_agg(bin_value)] OVER (PARTITION BY code ORDER BY id ASC NULLS LAST
                      [-unconvertible RS-244675 GROUPS between 1 preceding and current row]) AS rows_avg
from  t1;*/
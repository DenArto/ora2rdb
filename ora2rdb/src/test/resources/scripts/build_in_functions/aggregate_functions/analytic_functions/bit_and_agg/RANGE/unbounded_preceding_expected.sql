/*SELECT id,
       code,
       bin_value,
       [-unconvertible bit_and_agg(bin_value)] OVER (PARTITION BY code ORDER BY id
                      RANGE UNBOUNDED PRECEDING) AS rows_avg
from   t1;*/
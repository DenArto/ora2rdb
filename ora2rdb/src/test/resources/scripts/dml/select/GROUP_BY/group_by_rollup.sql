SELECT
    owner,
    COUNT(*) ownerobj#
FROM the_objects
GROUP BY ROLLUP(owner);
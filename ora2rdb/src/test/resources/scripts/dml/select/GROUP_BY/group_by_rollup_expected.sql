/*SELECT
    owner,
    COUNT(*) ownerobj#
FROM the_objects
GROUP BY [-unconvertible RS-241396 ROLLUP(owner)];*/
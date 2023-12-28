WITH SaleTimes AS (
    SELECT 
        ddt.year,
        CAST(ddt.timestamp AS time) AS sale_time,
        LEAD(CAST(ddt.timestamp AS time)) OVER (PARTITION BY ddt.year ORDER BY CAST(ddt.timestamp AS time)) - CAST(ddt.timestamp AS time) AS time_diff
    FROM 
        orders_table ot
    JOIN 
        dim_date_times ddt ON CAST(ot.date_uuid AS UUID) = ddt.date_uuid  -- Explicitly cast to UUID here
),
TimeDifferences AS (
    SELECT 
        year, 
        EXTRACT(EPOCH FROM time_diff) AS time_diff_seconds
    FROM 
        SaleTimes
    WHERE 
        time_diff IS NOT NULL
)
SELECT 
    year, 
    CONCAT(
        '"hours": ', FLOOR(AVG(time_diff_seconds) / 3600), ', ',
        '"minutes": ', FLOOR((AVG(time_diff_seconds) % 3600) / 60), ', ',
        '"seconds": ', FLOOR(AVG(time_diff_seconds) % 60), ', ',
        '"milliseconds": ', (AVG(time_diff_seconds) * 1000)::INTEGER % 1000, '...'
    ) AS actual_time_taken
FROM 
    TimeDifferences
GROUP BY 
    year
ORDER BY 
    year;
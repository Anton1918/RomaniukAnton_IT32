SELECT COUNT(*) AS all_trips,
       COUNT(duration_min) AS trips_with_duration
FROM trips;

SELECT COUNT(*) AS all_rows,
       COUNT(duration_min) AS non_null_values
FROM (
    SELECT duration_min FROM trips WHERE id = 1
    UNION ALL
    SELECT NULL
);

SELECT SUM(duration_min) AS total_duration_min,
       AVG(duration_min) AS average_duration_min
FROM trips;

SELECT MIN(trip_date) AS first_trip_date,
       MAX(trip_date) AS last_trip_date
FROM trips;

SELECT COUNT(*) AS trip_count,
       SUM(duration_min) AS total_duration_min,
       AVG(duration_min) AS average_duration_min,
       MIN(duration_min) AS min_duration_min,
       MAX(duration_min) AS max_duration_min
FROM trips;

SELECT COUNT(*) AS trip_count,
       SUM(duration_min) AS total_duration_min,
       AVG(duration_min) AS average_duration_min
FROM trips
WHERE duration_min > 200;
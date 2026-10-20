SELECT id, duration_min AS raw_duration,
       printf('%.2f хв', duration_min) AS formatted_duration
FROM trips
ORDER BY id;

SELECT id,
       printf('%8.2f', duration_min) AS aligned_duration,
       printf('%05d', duration_min) AS zero_padded_duration
FROM trips
ORDER BY id;

SELECT id, trip_date,
       date(trip_date, '+7 days') AS date_plus_7_days
FROM trips
ORDER BY id;

SELECT strftime('%Y', trip_date) AS trip_year,
       strftime('%m', trip_date) AS trip_month,
       COUNT(*) AS trips_count
FROM trips
GROUP BY strftime('%Y', trip_date), strftime('%m', trip_date)
ORDER BY trip_year, trip_month;

SELECT 'not-a-date' AS invalid_date,
       strftime('%Y', 'not-a-date') AS extracted_year,
       date('not-a-date') AS normalized_date;
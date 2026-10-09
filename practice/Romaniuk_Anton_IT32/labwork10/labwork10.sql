SELECT driver_id, COUNT(*) AS trips_count
FROM trips
GROUP BY driver_id
HAVING COUNT(*) > 1
ORDER BY driver_id;

SELECT driver_id, AVG(duration_min) AS avg_duration_min
FROM trips
GROUP BY driver_id
HAVING AVG(duration_min) < 200
ORDER BY driver_id;

SELECT driver_id, COUNT(*) AS trips_count,
       AVG(duration_min) AS avg_duration_min
FROM trips
WHERE duration_min >= 100
GROUP BY driver_id
HAVING COUNT(*) >= 2
ORDER BY driver_id;

SELECT driver_id, COUNT(*)
FROM trips
WHERE COUNT(*) > 1
GROUP BY driver_id;

SELECT d.id AS driver_id,
       d.last_name || ' ' || d.first_name AS driver_name,
       COUNT(t.id) AS trips_count
FROM drivers AS d
LEFT JOIN trips AS t ON t.driver_id = d.id
GROUP BY d.id
HAVING COUNT(t.id) < 3
ORDER BY d.id;
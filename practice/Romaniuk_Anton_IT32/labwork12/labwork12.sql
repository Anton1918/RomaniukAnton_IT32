SELECT id, driver_id, route_id, trip_date, duration_min
FROM trips
ORDER BY trip_date DESC;

SELECT id, driver_id, route_id, duration_min, trip_date
FROM trips
ORDER BY duration_min DESC, trip_date ASC;

SELECT id, driver_id, route_id, trip_date, duration_min
FROM trips
ORDER BY duration_min DESC
LIMIT 3;

SELECT DISTINCT license_category
FROM drivers
ORDER BY license_category;

SELECT id, origin, destination, distance_km
FROM routes
WHERE distance_km BETWEEN 130 AND 140
ORDER BY distance_km;

SELECT id, origin, destination, distance_km
FROM routes
WHERE origin IN ('Київ', 'Львів')
ORDER BY origin, destination;

SELECT id, last_name, first_name
FROM drivers
WHERE last_name LIKE 'Шев%';

SELECT id, last_name, first_name
FROM drivers
WHERE last_name LIKE 'шев%';
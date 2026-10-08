SELECT driver_id, COUNT(*) AS trips_count
FROM trips
GROUP BY driver_id;

SELECT drivers.last_name, drivers.first_name, COUNT(trips.id) AS trips_count
FROM drivers
LEFT JOIN trips ON trips.driver_id = drivers.id
GROUP BY drivers.id;

SELECT drivers.last_name, drivers.first_name,
       COUNT(trips.id) AS trips_count,
       AVG(trips.duration_min) AS average_duration_min
FROM drivers
LEFT JOIN trips ON trips.driver_id = drivers.id
GROUP BY drivers.id;

SELECT driver_id, route_id, COUNT(*) AS trips_count
FROM trips
GROUP BY driver_id, route_id;

SELECT COUNT(DISTINCT driver_id) AS unique_drivers,
       COUNT(DISTINCT route_id) AS unique_routes
FROM trips;

SELECT driver_id, trip_date, COUNT(*) AS trips_count
FROM trips
GROUP BY driver_id;

SELECT driver_id, trip_date, COUNT(*) AS trips_count
FROM trips
GROUP BY driver_id;
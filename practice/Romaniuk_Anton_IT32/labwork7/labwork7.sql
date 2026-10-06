PRAGMA foreign_keys = ON;

SELECT t.id AS trip_id,
       d.last_name || ' ' || d.first_name AS driver,
       t.trip_date,
       t.duration_min
FROM trips AS t
INNER JOIN drivers AS d ON t.driver_id = d.id
ORDER BY t.id;

SELECT t.id AS trip_id,
       d.last_name || ' ' || d.first_name AS driver,
       r.origin || ' → ' || r.destination AS route,
       t.trip_date,
       t.duration_min
FROM trips AS t
INNER JOIN drivers AS d ON t.driver_id = d.id
INNER JOIN routes AS r ON t.route_id = r.id
ORDER BY t.id;

INSERT INTO routes (id, origin, destination, distance_km)
VALUES (7, 'Тернопіль', 'Чернівці', 190.0);

SELECT r.id, r.origin, r.destination, r.distance_km
FROM routes AS r
LEFT JOIN trips AS t ON t.route_id = r.id
WHERE t.id IS NULL
ORDER BY r.id;

SELECT COUNT(*)
FROM drivers CROSS JOIN routes;

SELECT COUNT(*) FROM drivers;
SELECT COUNT(*) FROM routes;

SELECT COUNT(*)
FROM trips t, drivers d
WHERE t.driver_id = d.id;
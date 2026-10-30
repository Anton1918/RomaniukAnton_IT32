EXPLAIN QUERY PLAN
SELECT id, driver_id, route_id, trip_date
FROM trips
WHERE driver_id = 2;

CREATE INDEX idx_trips_driver_id ON trips(driver_id);
EXPLAIN QUERY PLAN
SELECT id, driver_id, route_id, trip_date
FROM trips
WHERE driver_id = 2;

EXPLAIN QUERY PLAN
SELECT id, driver_id, route_id, trip_date
FROM trips
WHERE driver_id = 1 AND route_id = 4;

CREATE INDEX idx_trips_driver_route ON trips(driver_id, route_id);
EXPLAIN QUERY PLAN
SELECT id, driver_id, route_id, trip_date
FROM trips
WHERE driver_id = 1 AND route_id = 4;

EXPLAIN QUERY PLAN
SELECT id, trip_date FROM trips ORDER BY trip_date ASC;

CREATE INDEX idx_trips_trip_date ON trips(trip_date);
EXPLAIN QUERY PLAN
SELECT id, trip_date FROM trips ORDER BY trip_date ASC;

DROP INDEX idx_trips_trip_date;
EXPLAIN QUERY PLAN
SELECT id, trip_date FROM trips ORDER BY trip_date ASC;

SELECT name, sql
FROM sqlite_master
WHERE type='index' AND tbl_name='trips'
ORDER BY name;
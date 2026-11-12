-- Завдання 1.
ALTER TABLE trips
ADD COLUMN duration_hours REAL
GENERATED ALWAYS AS (duration_min / 60.0) VIRTUAL;

SELECT id, duration_min, duration_hours
FROM trips
ORDER BY id;

-- Завдання 2.
ALTER TABLE drivers_routes
ADD COLUMN is_active INTEGER
GENERATED ALWAYS AS (
    CASE
        WHEN status IS NULL THEN NULL
        WHEN status = 'активний' THEN 1
        ELSE 0
    END
) VIRTUAL;

SELECT id, status, is_active
FROM drivers_routes
ORDER BY id;

-- Завдання 4.
SELECT id, duration_min, duration_hours
FROM trips
WHERE id = 1;

UPDATE trips
SET duration_min = 180
WHERE id = 1;

SELECT id, duration_min, duration_hours
FROM trips
WHERE id = 1;

-- Завдання 5.
SELECT id, driver_id, route_id, duration_min, duration_hours
FROM trips
WHERE duration_hours > 2
ORDER BY duration_hours DESC;
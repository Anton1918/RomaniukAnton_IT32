-- Завдання 1.
CREATE DATABASE transport_db;

-- Завдання 2.
CREATE TABLE drivers (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    experience_years INTEGER NOT NULL,
    license_category TEXT NOT NULL
);

CREATE TABLE routes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    origin TEXT NOT NULL,
    destination TEXT NOT NULL,
    distance_km REAL NOT NULL
);

CREATE TABLE trips (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    driver_id INTEGER NOT NULL,
    route_id INTEGER NOT NULL,
    trip_date DATE NOT NULL,
    duration_min INTEGER NOT NULL,
    FOREIGN KEY (driver_id) REFERENCES drivers(id),
    FOREIGN KEY (route_id) REFERENCES routes(id)
);

-- Завдання 4.
SELECT setval(pg_get_serial_sequence('drivers', 'id'), (SELECT MAX(id) FROM drivers));
SELECT setval(pg_get_serial_sequence('routes',  'id'), (SELECT MAX(id) FROM routes));
SELECT setval(pg_get_serial_sequence('trips',   'id'), (SELECT MAX(id) FROM trips));

-- Тестові рядки без явного id
INSERT INTO drivers (last_name, first_name, experience_years, license_category)
VALUES ('Тестовий', 'Водій', 1, 'B')
INSERT INTO routes (origin, destination, distance_km)
VALUES ('Тест', 'Місто', 10.0)
INSERT INTO trips (driver_id, route_id, trip_date, duration_min)
VALUES (1, 1, '2026-09-15', 100)

-- Завдання 5.
SELECT COUNT(*) FROM drivers;
SELECT COUNT(*) FROM routes;
SELECT COUNT(*) FROM trips;

-- Свідома помилка
INSERT INTO trips (driver_id, route_id, trip_date, duration_min)
VALUES (999, 1, '2026-09-16', 90);
PRAGMA foreign_keys = ON;

CREATE TABLE driver_routes (
    id INTEGER PRIMARY KEY,
    driver_id INTEGER NOT NULL,
    route_id INTEGER NOT NULL,
    permission_status TEXT NOT NULL DEFAULT 'Дозволено'
        CHECK (permission_status IN ('Дозволено', 'Тимчасово', 'Призупинено')),
    valid_from TEXT NOT NULL,
    note TEXT NOT NULL,
    FOREIGN KEY (driver_id) REFERENCES drivers(id) ON DELETE RESTRICT,
    FOREIGN KEY (route_id) REFERENCES routes(id) ON DELETE RESTRICT
);

INSERT INTO drivers (id, last_name, first_name, experience_years, license_category)
VALUES (6, 'Савчук', 'Олег', 4, 'B, C');

INSERT INTO driver_routes (driver_id, route_id, permission_status, valid_from, note) VALUES
(1,1,'Дозволено','2026-08-01','Основний маршрут'),
(1,2,'Дозволено','2026-08-01','Міжміський маршрут'),
(1,4,'Тимчасово','2026-09-01','Тимчасовий допуск'),
(2,1,'Дозволено','2026-08-10','Основний маршрут'),
(2,3,'Дозволено','2026-08-10','Регіональний маршрут'),
(2,5,'Призупинено','2026-09-05','Допуск призупинено'),
(3,1,'Дозволено','2026-07-15','Основний маршрут'),
(3,2,'Дозволено','2026-07-15','Міжміський маршрут'),
(3,3,'Дозволено','2026-07-15','Регіональний маршрут'),
(3,6,'Тимчасово','2026-09-02','Тимчасовий допуск'),
(4,5,'Дозволено','2026-08-20','Основний маршрут'),
(4,7,'Тимчасово','2026-09-03','Тимчасовий допуск'),
(5,2,'Дозволено','2026-08-12','Міжміський маршрут'),
(5,4,'Дозволено','2026-08-12','Регіональний маршрут');

SELECT d.id, d.last_name || ' ' || d.first_name AS driver_name,
       COUNT(dr.id) AS permissions_count
FROM drivers d
JOIN driver_routes dr ON dr.driver_id = d.id
JOIN routes r ON r.id = dr.route_id
GROUP BY d.id
ORDER BY d.id;

SELECT d.id, d.last_name || ' ' || d.first_name AS driver_name,
       COUNT(dr.id) AS permissions_count
FROM drivers d
JOIN driver_routes dr ON dr.driver_id = d.id
JOIN routes r ON r.id = dr.route_id
GROUP BY d.id
HAVING COUNT(dr.id) >= 2
ORDER BY d.id;

SELECT d.last_name || ' ' || d.first_name AS driver_name,
       r.origin || ' — ' || r.destination AS route_name,
       COUNT(dr.id) AS permissions_count
FROM drivers d
JOIN driver_routes dr ON dr.driver_id = d.id
JOIN routes r ON r.id = dr.route_id
WHERE dr.permission_status <> 'Призупинено'
GROUP BY d.id, r.id
HAVING COUNT(dr.id) >= 1
ORDER BY d.id, r.id;

INSERT INTO driver_routes (driver_id, route_id, permission_status, valid_from, note)
VALUES (2,4,'Дозволено','2026-10-01','Основний маршрут');

SELECT dr.id, dr.note, COUNT(*) AS row_count
FROM drivers d JOIN driver_routes dr ON dr.driver_id=d.id
JOIN routes r ON r.id=dr.route_id
GROUP BY dr.id, dr.note ORDER BY dr.id;

SELECT dr.note, COUNT(*) AS permissions_count
FROM drivers d JOIN driver_routes dr ON dr.driver_id=d.id
JOIN routes r ON r.id=dr.route_id
GROUP BY dr.note ORDER BY dr.note;

SELECT d.id, d.last_name || ' ' || d.first_name AS driver_name,
       COUNT(dr.id) AS permissions_count
FROM drivers d
LEFT JOIN driver_routes dr ON dr.driver_id=d.id
LEFT JOIN routes r ON r.id=dr.route_id
GROUP BY d.id ORDER BY d.id;
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS drivers_routes (
 id INTEGER PRIMARY KEY,
 driver_id INTEGER NOT NULL,
 route_id INTEGER NOT NULL,
 permitted_since TEXT NOT NULL,
 status TEXT NOT NULL DEFAULT 'активний'
   CHECK(status IN ('активний','призупинений')),
 UNIQUE(driver_id, route_id),
 FOREIGN KEY(driver_id) REFERENCES drivers(id) ON DELETE RESTRICT,
 FOREIGN KEY(route_id) REFERENCES routes(id) ON DELETE RESTRICT
);
INSERT OR IGNORE INTO drivers_routes(id,driver_id,route_id,permitted_since,status) VALUES
 (1,1,1,'2026-09-01','активний'),
 (2,1,2,'2026-09-02','активний'),
 (3,2,2,'2026-09-02','активний'),
 (4,2,5,'2026-09-03','активний'),
 (5,3,1,'2026-09-04','активний'),
 (6,3,3,'2026-09-04','активний'),
 (7,4,5,'2026-09-05','активний'),
 (8,5,4,'2026-09-06','активний');

SELECT dr.id,d.last_name||' '||d.first_name AS driver,
 r.origin||' — '||r.destination AS route,dr.permitted_since,dr.status
FROM drivers_routes dr JOIN drivers d ON d.id=dr.driver_id
JOIN routes r ON r.id=dr.route_id ORDER BY dr.id;

BEGIN;
INSERT INTO drivers_routes(driver_id,route_id,permitted_since,status)
VALUES(4,6,'2026-10-01','призупинений');
UPDATE drivers_routes SET status='активний' WHERE driver_id=4 AND route_id=6;
SELECT * FROM drivers_routes WHERE driver_id=4 AND route_id=6;
COMMIT;

BEGIN;
INSERT INTO drivers_routes(driver_id,route_id,permitted_since,status)
VALUES(5,6,'2026-10-02','активний');
SELECT * FROM drivers_routes WHERE driver_id=5 AND route_id=6;
ROLLBACK;
SELECT * FROM drivers_routes WHERE driver_id=5 AND route_id=6;

BEGIN;
UPDATE drivers_routes SET status='призупинений' WHERE id=1;
SELECT * FROM drivers_routes WHERE id=1;
ROLLBACK;

BEGIN;
INSERT INTO drivers_routes(driver_id,route_id,permitted_since,status)
VALUES(2,6,'2026-10-03','активний');
INSERT INTO drivers_routes(driver_id,route_id,permitted_since,status)
VALUES(2,6,'2026-10-04','активний');
SELECT * FROM drivers_routes WHERE driver_id=2 AND route_id=6;
ROLLBACK;

BEGIN;
INSERT INTO drivers_routes(driver_id,route_id,permitted_since,status)
VALUES(5,3,'2026-10-05','активний');
INSERT INTO drivers_routes(driver_id,route_id,permitted_since,status)
VALUES(5,3,'2026-10-06','активний');
COMMIT;
SELECT * FROM drivers_routes WHERE driver_id=5 AND route_id=3;

PRAGMA foreign_keys;
PRAGMA foreign_key_list(drivers_routes);
SELECT COUNT(*) AS assignments_count FROM drivers_routes;
SELECT * FROM drivers_routes ORDER BY id;
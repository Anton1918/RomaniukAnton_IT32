-- Практична робота №4, варіант 10 — Транспортна компанія
PRAGMA foreign_keys = ON;

-- drivers (таблиця-вимір 1)
CREATE TABLE drivers (id INTEGER PRIMARY KEY,last_name TEXT NOT NULL,first_name TEXT NOT NULL,experience_years INTEGER,license_category TEXT NOT NULL);
INSERT INTO drivers VALUES (1,'Шевченко','Олександр',8,'C'),(2,'Коваленко','Максим',5,'B, C'),(3,'Бондаренко','Андрій',12,'C, CE'),(4,'Мельник','Дмитро',3,'B'),(5,'Ткаченко','Віталій',10,'D, DE');

-- Завдання 1: routes (таблиця-вимір 2)
CREATE TABLE routes (id INTEGER PRIMARY KEY,origin TEXT NOT NULL,destination TEXT NOT NULL,distance_km REAL NOT NULL);
INSERT INTO routes VALUES (1,'Луцьк','Львів',150.0),(2,'Луцьк','Київ',390.0),(3,'Львів','Тернопіль',130.0),(4,'Київ','Житомир',140.0),(5,'Рівне','Луцьк',70.0),(6,'Львів','Ужгород',270.0);

-- Завдання 2: trips (фактова таблиця). RESTRICT зберігає історію поїздок.
CREATE TABLE trips (id INTEGER PRIMARY KEY,driver_id INTEGER NOT NULL,route_id INTEGER NOT NULL,trip_date TEXT NOT NULL,duration_min INTEGER NOT NULL,FOREIGN KEY(driver_id) REFERENCES drivers(id) ON DELETE RESTRICT,FOREIGN KEY(route_id) REFERENCES routes(id) ON DELETE RESTRICT);
INSERT INTO trips VALUES (1,1,1,'2026-09-01',150),(2,2,2,'2026-09-02',300),(3,3,3,'2026-09-03',130),(4,4,5,'2026-09-04',80),(5,5,4,'2026-09-05',120),(6,1,6,'2026-09-06',240),(7,3,1,'2026-09-08',155),(8,5,2,'2026-09-10',315),(9,2,5,'2026-09-11',75),(10,1,4,'2026-09-12',125);

-- Завдання 3: перевірка зв'язків
SELECT t.id,d.last_name||' '||d.first_name AS driver,r.origin||' — '||r.destination AS route,t.trip_date,t.duration_min FROM trips t JOIN drivers d ON d.id=t.driver_id JOIN routes r ON r.id=t.route_id ORDER BY t.id;

-- Завдання 4: виконайте ОКРЕМО, щоб отримати FOREIGN KEY constraint failed:
-- INSERT INTO trips(driver_id,route_id,trip_date,duration_min) VALUES (999,1,'2026-09-15',100);

-- Завдання 5
PRAGMA foreign_keys;
PRAGMA foreign_key_list(trips);

CREATE TABLE drivers (
    id INTEGER PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    experience_years INTEGER NOT NULL,
    license_category TEXT NOT NULL
);

INSERT INTO drivers (id, last_name, first_name, experience_years, license_category) VALUES
(1, 'Шевченко', 'Олександр', 8, 'C'),
(2, 'Коваленко', 'Максим', 5, 'B, C'),
(3, 'Бондаренко', 'Андрій', 12, 'C, CE'),
(4, 'Мельник', 'Дмитро', 3, 'B'),
(5, 'Ткаченко', 'Віталій', 10, 'D, DE');

SELECT * FROM drivers;

-- Завдання 1.
SELECT COUNT(*) AS drivers_before_import FROM drivers;

-- Завдання 2.
CREATE TABLE drivers_staging (
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    experience_years INTEGER NOT NULL,
    license_category TEXT NOT NULL
);

-- Перевірка імпортованих даних у проміжній таблиці:
SELECT * FROM drivers_staging;
SELECT COUNT(*) AS staging_rows FROM drivers_staging;

-- Завдання 3.
INSERT INTO drivers (last_name, first_name, experience_years, license_category)
SELECT last_name, first_name, experience_years, license_category
FROM drivers_staging;

DROP TABLE drivers_staging;

SELECT COUNT(*) AS drivers_after_import FROM drivers;

-- Завдання 4.
SELECT id, last_name, first_name, experience_years, license_category
FROM drivers
WHERE id BETWEEN 6 AND 13
ORDER BY id;
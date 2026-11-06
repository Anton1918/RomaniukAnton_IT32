-- Завдання 1.
CREATE TABLE drivers_staging (
    last_name TEXT,
    first_name TEXT,
    experience_years INTEGER,
    license_category TEXT
);
.mode csv
.import
SELECT COUNT(*) FROM drivers_staging;
SELECT * FROM drivers_staging LIMIT 1;
DELETE FROM drivers_staging;

-- Завдання 2.
.mode csv
.separator ";"
.import
SELECT COUNT(*) FROM drivers_staging;

-- Завдання 3.
SELECT SUM(last_name = '')  AS last_name_empty,
       SUM(first_name = '') AS first_name_empty,
       SUM(experience_years = '') AS experience_years_empty,
       SUM(license_category = '') AS license_category_empty
FROM drivers_staging;
SELECT typeof(experience_years), COUNT(*) FROM drivers_staging GROUP BY 1;
SELECT last_name, first_name, experience_years, license_category, COUNT(*) AS cnt
FROM drivers_staging
GROUP BY last_name, first_name, experience_years, license_category
HAVING COUNT(*) > 1;
.schema drivers

-- Завдання 4.
SELECT COUNT(*), MAX(id) FROM drivers;
INSERT INTO drivers (last_name, first_name, experience_years, license_category)
SELECT DISTINCT last_name, first_name, experience_years, license_category
FROM drivers_staging
WHERE experience_years <> '';
SELECT COUNT(*), MAX(id) FROM drivers;
SELECT COUNT(*) FROM drivers WHERE experience_years IS NULL;
DROP TABLE drivers_staging;


-- Завдання 5.
.headers on
.mode csv
.output drivers_export.csv
SELECT id, last_name, first_name, experience_years, license_category FROM drivers WHERE id > 13;
.output stdout
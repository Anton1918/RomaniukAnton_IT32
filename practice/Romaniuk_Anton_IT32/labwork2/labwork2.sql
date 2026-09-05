-- Завдання 1
SELECT last_name, first_name, experience_years, license_category
FROM drivers;

-- Завдання 2: стаж більший за 5 років
SELECT last_name, first_name, experience_years
FROM drivers
WHERE experience_years > 5;

-- Завдання 3: перші 3 записи
SELECT last_name, first_name, experience_years
FROM drivers
LIMIT 3;

-- Завдання 4: невідомий стаж
SELECT last_name, first_name, experience_years
FROM drivers
WHERE experience_years IS NULL;

-- Завдання 4: відомий стаж
SELECT last_name, first_name, experience_years
FROM drivers
WHERE experience_years IS NOT NULL;

-- Завдання 5: стаж > 5 років І є категорія C
SELECT last_name, first_name, experience_years, license_category
FROM drivers
WHERE experience_years > 5
  AND license_category LIKE '%C%';
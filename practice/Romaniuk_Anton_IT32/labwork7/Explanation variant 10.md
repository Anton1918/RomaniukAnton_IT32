# Завдання 1. COUNT(*) проти COUNT(колонка)
`SELECT COUNT(*) FROM trips;` -> **10**
`SELECT COUNT(duration_min) FROM trips;` -> **10**
Оскільки в колонці `duration_min` немає значень `NULL`, обидва результати збігаються. Якщо штучно встановити `NULL` для одного рядка (`UPDATE trips SET duration_min=NULL WHERE id=1;`), то `COUNT(*)` = 10, а `COUNT(duration_min)` = 9.

# Завдання 2. SUM і AVG
`SELECT SUM(duration_min) AS total_duration, AVG(duration_min) AS avg_duration FROM trips;`
Результат: **SUM = 1600 хв**, **AVG = 160 хв**. 
Сумарна тривалість усіх поїздок становить 1600 хвилин, а середня тривалість однієї поїздки — 160 хвилин.

# Завдання 3. MIN/MAX (не на числах)
`SELECT MIN(departure_time) AS earliest, MAX(departure_time) AS latest FROM trips;`
Результат: **найраніший час відправлення** та **найпізніший час**.
Для текстових або датових типів СУБД визначає "найменше" значення лексикографічно (для тексту) або хронологічно (для дати/часу).

# Завдання 4. Кілька агрегатних функцій в одному запиті
`SELECT COUNT(*) AS total_trips, SUM(duration_min) AS total_time, AVG(duration_min) AS avg_time, MIN(duration_min) AS min_time, MAX(duration_min) AS max_time FROM trips;`
Результат: **10, 1600, 160, 150, 180** (приклад).

# Завдання 5. Агрегат + WHERE
`SELECT AVG(duration_min) AS avg_duration FROM trips WHERE route_id = 1;`
Результат: **155 хв**.
`WHERE` фільтрує рядки *перед* обчисленням, тому в розрахунок середнього потрапляють лише поїздки за маршрутом 1, що змінює результат порівняно з усією таблицею.

# Контрольні питання

1. **COUNT(*)** рахує всі рядки, а **COUNT(колонка)** — лише ті, де значення не `NULL`. Для `id` (первинний ключ) вони завжди однакові.
2. Якщо 5 рядків, а 1 з них `NULL`, знаменник для `AVG` буде **4**, бо `AVG` ігнорує `NULL`.
3. `SUM(колонка)` при всіх `NULL` повертає **NULL** (не 0 і не помилку), оскільки сума порожньої множини не визначена.
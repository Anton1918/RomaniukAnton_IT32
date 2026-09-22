# Завдання 1
Створено `routes`: `id INTEGER PRIMARY KEY`, `origin TEXT`, `destination TEXT`, `distance_km REAL`. Додано 6 реалістичних маршрутів.

# Завдання 2
Створено фактова таблиця `trips` з `id` як PK та двома FK: `driver_id → drivers.id` і `route_id → routes.id`. Додано 10 поїздок. Для обох FK обрано `ON DELETE RESTRICT`, тому водія або маршрут не можна видалити, якщо існують поїздки, що на них посилаються. Це зберігає історичні дані.

# Завдання 3
Через `JOIN` перевірено, що кожна з 10 поїздок має існуючого водія та існуючий маршрут.

# Завдання 4
Окремо виконати: `INSERT INTO trips(driver_id,route_id,trip_date,duration_min) VALUES (999,1,'2026-09-15',100);` Очікувана помилка SQLite: `FOREIGN KEY constraint failed`. Це доводить, що `PRAGMA foreign_keys = ON` реально працює.

# Завдання 5
Структура відповідає ER-діаграмі Практичної 3: `drivers.id` — PK, `routes.id` — PK, `trips.id` — PK, а `trips.driver_id` і `trips.route_id` — FK до відповідних таблиць.

# Контрольні питання

**1. Навіщо `PRAGMA foreign_keys = ON`?**
У SQLite перевірка зовнішніх ключів вмикається для поточного з'єднання окремо. `PRAGMA foreign_keys = ON` змушує SQLite реально контролювати відповідність FK.

**2. Різниця між PRIMARY KEY і FOREIGN KEY.**
PRIMARY KEY однозначно ідентифікує запис у власній таблиці. FOREIGN KEY посилається на ключ іншої таблиці та встановлює зв'язок між таблицями.

**3. CASCADE і RESTRICT.**
`ON DELETE CASCADE` автоматично видаляє залежні записи. `ON DELETE RESTRICT` забороняє видалення батьківського запису, якщо на нього є посилання. Для історії поїздок доцільний RESTRICT, щоб не знищувати історичні дані.
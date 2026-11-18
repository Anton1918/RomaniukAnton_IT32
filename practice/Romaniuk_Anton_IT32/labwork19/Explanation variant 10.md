# Завдання 1. База даних

У pgAdmin: правий клік на `Databases` → `Create` → `Database`, назва **`transport_db`** (SQL: `CREATE DATABASE transport_db;`). Query Tool відкрито саме на цій базі.

# Завдання 2. Переклад CREATE TABLE

Зміни порівняно з SQLite:

- `INTEGER PRIMARY KEY` на `INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY`;
- типи: `TEXT`, `INTEGER`, `REAL` (`distance_km`) збережено; `trip_date` — `DATE` (дата, а не текст);
- `FOREIGN KEY` фактової таблиці `trips` (`driver_id → drivers(id)`, `route_id → routes(id)`) залишено; `PRAGMA foreign_keys` не потрібна, бо PostgreSQL перевіряє зовнішні ключі завжди.

Створено в порядку: `drivers`, `routes`, `trips`.

# Завдання 3. Перенесення даних

1. Зі SQLite експортовано кожну таблицю в CSV із рядком заголовків і всіма колонками, включно з `id` (файли `csv19/drivers.csv`, `csv19/routes.csv`, `csv19/trips.csv`; колонки в тому ж порядку, що й у `CREATE TABLE`).
2. У pgAdmin: правий клік на таблиці → `Import/Export Data`, режим `Import`, формат `csv`, на вкладці `Options` — `Header` увімкнено.
3. Порядок: спершу таблиці-виміри (`drivers`, `routes`), потім фактова `trips`, щоб зовнішні ключі одразу знаходили свої рядки.

## Завдання 4. Виправлення лічильника `id`

Після імпорту стовпець `id` узяв значення з файлу, а лічильник (послідовність) лишився на початку. Тому виконано:

```sql
SELECT setval(pg_get_serial_sequence('drivers', 'id'), (SELECT MAX(id) FROM drivers));
SELECT setval(pg_get_serial_sequence('routes',  'id'), (SELECT MAX(id) FROM routes));
SELECT setval(pg_get_serial_sequence('trips',   'id'), (SELECT MAX(id) FROM trips));
```

Тестові `INSERT` без явного `id` отримують наступні номери: `drivers` → **21**, `routes` → **7**, `trips` → **11**. Лічильник продовжує нумерацію і не повторює вже зайняті значення.

## Завдання 5. Перевірка цілісності

Без тестових рядків числа збігаються: 20, 6, 10.

Свідома помилка — `INSERT` у `trips` із `driver_id = 999`, якого немає в `drivers`. Текст помилки PostgreSQL:

```
ERROR:  insert or update on table "trips" violates foreign key constraint "trips_driver_id_fkey"
DETAIL:  Key (driver_id)=(999) is not present in table "drivers".
```

# Контрольні запитання

1. SQLite — вбудована БД у одному файлі без сервера; PostgreSQL — клієнт-серверна СУБД (ієрархія: сервер → бази даних → схеми → таблиці), з багатьма користувачами й підключеннями.
2. `GENERATED ALWAYS AS IDENTITY` відповідає стандарту SQL і не дозволяє випадково вставити довільний `id`; `SERIAL` — застарілий нестандартний скорочений запис, який створює послідовність і значення за замовчуванням, а явне значення вставити можна.
3. Зовнішній ключ фактової таблиці посилається на рядки таблиць-вимірів, тому вони мають існувати першими, інакше імпорт `trips` завершиться помилкою зовнішнього ключа.
4. Лічильник лишився б на 1, і новий `INSERT` без `id` спробував би взяти вже зайнятий номер: `ERROR: duplicate key value violates unique constraint "drivers_pkey"`, `DETAIL: Key (id)=(1) already exists.`
5. pgAdmin — графічний клієнт для керування сервером (створення баз, імпорт/експорт), а Query Tool — редактор SQL-запитів у ньому; відповідає DB Browser for SQLite.
6. У PostgreSQL перевірка зовнішніх ключів увімкнена завжди, а `PRAGMA foreign_keys` — налаштування окремого з'єднання SQLite, яке за замовчуванням вимкнене.
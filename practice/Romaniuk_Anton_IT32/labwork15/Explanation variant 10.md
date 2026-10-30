1. Для запиту за `driver_id` до створення індексу отримано план: `SCAN trips`. SQLite переглядала таблицю.
2. Створено `idx_trips_driver_id` на зовнішньому ключі `trips.driver_id`. Після цього план: `SEARCH trips USING INDEX idx_trips_driver_id (driver_id=?)` — пошук виконується через індекс.
3. Для умов `driver_id = 1 AND route_id = 4` до композитного індексу план був: `SEARCH trips USING INDEX idx_trips_driver_id (driver_id=?)`. Створено `idx_trips_driver_route` на `(driver_id, route_id)`. Після цього: `SEARCH trips USING INDEX idx_trips_driver_route (driver_id=? AND route_id=?)`. Композитний індекс враховує обидві умови й може звузити пошук ефективніше, ніж індекс лише на першій колонці.
4. Для `ORDER BY trip_date` до індексу план був: `SCAN trips | USE TEMP B-TREE FOR ORDER BY`. Після створення `idx_trips_trip_date` план став: `SCAN trips USING COVERING INDEX idx_trips_trip_date` — індекс може надати рядки у потрібному порядку без окремого сортування.
5. Індекс `idx_trips_trip_date` видалено командою `DROP INDEX`. Після видалення план: `SCAN trips | USE TEMP B-TREE FOR ORDER BY`. У фінальній базі залишилися індекси на `driver_id` та `(driver_id, route_id)`.

# Контрольні питання

1. Він описує спосіб, яким SQLite планує виконати запит: сканування таблиці, пошук через індекс, використання тимчасового сортування тощо. Правильність самих даних перевіряють виконанням `SELECT`.

2. Для умови з двома колонками одноколонковий індекс звужує пошук лише за `driver_id`, після чого SQLite перевіряє `route_id`. Композитний індекс `(driver_id, route_id)` враховує обидві умови одразу.

3. Індекси займають додаткове місце та потребують оновлення під час `INSERT`, `UPDATE` і `DELETE`. Надмірна кількість індексів уповільнює зміну даних, тому їх створюють для колонок, які справді часто використовуються у фільтрації, з'єднаннях або сортуванні.
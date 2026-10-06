PRAGMA foreign_keys=ON;
UPDATE trips SET duration_min=160 WHERE id=1;
UPDATE routes SET distance_km=155.0 WHERE id=1;
DELETE FROM trips WHERE id=10;
SELECT COUNT(*) FROM trips;
PRAGMA foreign_key_list(trips);
-- Перевірка ON DELETE RESTRICT:
-- DELETE FROM drivers WHERE id=1;
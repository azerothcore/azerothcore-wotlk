-- DB update 2026_03_25_05 -> 2026_03_25_06
-- Remove smoothTransition for Guardian of Life (33528)
UPDATE `waypoint_data` SET `smoothTransition` = 0 WHERE `id` IN (1375280, 1375290, 1375300, 1375310);

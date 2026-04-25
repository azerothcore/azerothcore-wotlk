-- DB update 2026_04_25_02 -> 2026_04_25_03
--
-- Remove AoE spell cast to entry, that may sometimes not be in range.
DELETE FROM `waypoint_scripts` WHERE `id` IN (488, 489, 490) AND `guid` IN (891, 892, 893);
UPDATE `waypoint_data` SET `action` = 0 WHERE `id` = 1365540 AND `point` IN (4, 10, 18);

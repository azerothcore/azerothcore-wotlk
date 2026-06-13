-- DB update 2026_03_04_02 -> 2026_03_04_03

-- Set delay and orientations.
UPDATE `waypoint_data` SET `delay` = 30000 WHERE (`id` IN(1365990, 1366000));
UPDATE `waypoint_data` SET `orientation` = 3.8013816 WHERE `id` = 1365990 AND `point` = 2;
UPDATE `waypoint_data` SET `orientation` = 2.4547093 WHERE `id` = 1366000 AND `point` = 1;

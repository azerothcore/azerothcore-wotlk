-- DB update 2026_10_03_02 -> 2026_10_03_03
-- Hadronox adds no longer use these paths, they pathfind down the ramp
DELETE FROM `waypoint_data` WHERE `id` IN (3000012, 3000013, 3000014);

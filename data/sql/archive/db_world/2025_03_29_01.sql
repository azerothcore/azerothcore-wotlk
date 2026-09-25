-- DB update 2025_03_29_00 -> 2025_03_29_01

-- Set Wander Distance and Movement Type
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 28557) AND (`guid` IN (128755, 128761, 128763));

-- Set Orientation
UPDATE `creature` SET `orientation` = 5.80374 WHERE `guid` = 128758 AND `id1` = 28557;
UPDATE `creature` SET `orientation` = 6.14145 WHERE `guid` = 128766 AND `id1` = 28557;

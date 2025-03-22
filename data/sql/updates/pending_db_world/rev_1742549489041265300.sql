-- Fix invalid banner name
UPDATE `gameobject_template` SET `name` = 'Alliance Banner' WHERE (`entry` = 192269 AND `name` = 'Horde Banner');

-- Rotate existing banners
UPDATE `gameobject` SET `orientation` = 4.71, `rotation2` = 0, `rotation3` = 0 WHERE (`guid` = 75179 AND `id` = 192415);
UPDATE `gameobject` SET `orientation` = 4.71, `rotation2` = 0, `rotation3` = 0 WHERE (`guid` = 75186 AND `id` = 192441);
UPDATE `gameobject` SET `orientation` = 4.71, `rotation2` = 0, `rotation3` = 0 WHERE (`guid` = 75190 AND `id` = 192449);
UPDATE `gameobject` SET `orientation` = 4.71, `rotation2` = 0, `rotation3` = 0 WHERE (`guid` = 75191 AND `id` = 192450);

-- Add missing Fortress banners
DELETE FROM `gameobject` WHERE (`guid` IN (74696, 74706) AND `id` = 192487);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(74696, 192487, 571, 0, 0, 1, 128, 5158.81, 2883.13, 431.618, 3.14159, 0, 0, 0, 0, 0, 0, 0, '', 0, NULL),
(74706, 192487, 571, 0, 0, 1, 128, 5160.34, 2798.61, 430.769, 3.14159, 0, 0, 0, 0, 0, 0, 0, '', 0, NULL);
DELETE FROM `gameobject` WHERE (`guid` = 74683 AND `id` = 192488);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(74683, 192488, 571, 0, 0, 1, 64, 5280.89, 3064.95, 431.976, 1.55334, 0, 0, 0, 0, 0, 0, 0, '', 0, NULL);

-- Add missing Workshop banners
DELETE FROM `gameobject` WHERE (`guid` IN (75195, 75196) AND `id` = 192430);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(75195, 192430, 571, 0, 0, 1, 64, 4438.38, 3361.01, 371.814, 0.0348707, 0, 0, -0.017452, 0.999848, 0, 0, 0, '', 0, NULL),
(75196, 192430, 571, 0, 0, 1, 64, 4416.8, 2414.04, 377.487, 0.00895035, 0, 0, 0.004363, 0.99999, 0, 0, 0, '', 0, NULL);

-- Add missing Tower banners
DELETE FROM `gameobject` WHERE (`guid` IN (76031, 76032, 76033, 76034, 76035, 76036, 76037, 76038, 76039, 76040, 76041, 76042) and `id` = 192501);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76031, 192501, 571, 0, 0, 1, 64, 4398.82, 2804.7, 429.792, -1.58825, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76032, 192501, 571, 0, 0, 1, 64, 4416, 2822.67, 429.851, -0.017452, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76033, 192501, 571, 0, 0, 1, 64, 4559.11, 3606.22, 419.999, -1.48353, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76034, 192501, 571, 0, 0, 1, 64, 4539.42, 3622.49, 420.034, -3.07177, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76035, 192501, 571, 0, 0, 1, 64, 4555.26, 3641.65, 419.974, 1.67551, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76036, 192501, 571, 0, 0, 1, 64, 4574.87, 3625.91, 420.079, 0.087266, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76037, 192501, 571, 0, 0, 1, 64, 4466.79, 1960.42, 459.144, 1.15192, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76038, 192501, 571, 0, 0, 1, 64, 4475.35, 1937.03, 459.07, -0.436332, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76039, 192501, 571, 0, 0, 1, 64, 4451.76, 1928.1, 459.076, -2.00713, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76040, 192501, 571, 0, 0, 1, 64, 4442.99, 1951.9, 459.093, 2.74016, 0, 0, 0, 1, 180, 0, 1, '', 0, NULL),
(76041, 192501, 571, 0, 0, 1, 64, 4380.36, 2822.38, 429.882, -3.10665, 0, 0, 0, 0, 120, 0, 1, '', 0, NULL),
(76042, 192501, 571, 0, 0, 1, 64, 4397.66, 2840.3, 429.922, 1.58825, 0, 0, 0, 0, 120, 0, 1, '', 0, NULL);

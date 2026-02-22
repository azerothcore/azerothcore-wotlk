-- DB update 2026_02_21_04 -> 2026_02_22_00
--
DELETE FROM `creature_template_addon` WHERE `entry` = 30084;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(30084, 0, 0, 0, 0, 0, 0, '55845');

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 30084;
INSERT INTO `creature_template_movement` (`CreatureId`, `Flight`) VALUES
(30084, 1);

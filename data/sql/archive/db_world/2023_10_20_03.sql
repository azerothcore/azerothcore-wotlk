-- DB update 2023_10_20_02 -> 2023_10_20_03
--
DELETE FROM `creature_template_addon` WHERE `entry` = 21229;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(21229, 0, 0, 0, 1, 0, 0, '38620');

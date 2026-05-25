-- DB update 2024_11_06_06 -> 2024_11_06_07
-- Darting Hatchling
DELETE FROM `creature_template_addon` WHERE (`entry` = 35396);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(35396, 0, 0, 0, 0, 0, 0, '62586');

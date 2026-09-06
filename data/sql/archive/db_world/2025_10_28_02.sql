-- DB update 2025_10_28_01 -> 2025_10_28_02
--
DELETE FROM `creature_template_addon` WHERE (`entry` = 30967);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(30967, 0, 0, 0, 0, 0, 0, '59143');

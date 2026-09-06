-- DB update 2025_10_26_03 -> 2025_10_28_00
--
DELETE FROM `creature_template_addon` WHERE (`entry` = 30966);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(30966, 0, 0, 0, 0, 0, 0, '61367');

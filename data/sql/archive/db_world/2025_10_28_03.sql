-- DB update 2025_10_28_02 -> 2025_10_28_03
--
DELETE FROM `creature_template_addon` WHERE (`entry` = 30964);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(30964, 0, 0, 0, 0, 0, 0, '59140');

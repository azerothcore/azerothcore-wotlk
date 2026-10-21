-- DB update 2026_08_15_01 -> 2026_08_15_02
--
DELETE FROM `creature_template_addon` WHERE (`entry` = 29689);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(29689, 0, 0, 0, 1, 333, 0, '');

DELETE FROM `creature_template_addon` WHERE (`entry` = 29688);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(29688, 0, 0, 0, 1, 233, 0, '');

DELETE FROM `creature_template_addon` WHERE (`entry` = 29691);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(29691, 0, 0, 7, 0, 0, 0, '');

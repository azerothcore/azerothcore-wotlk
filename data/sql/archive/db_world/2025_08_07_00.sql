-- DB update 2025_08_06_04 -> 2025_08_07_00

-- Init creature_template_addon (Wastes Scavenger)
DELETE FROM `creature_template_addon` WHERE (`entry` = 28005);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(28005, 0, 0, 0, 0, 438, 0, '');

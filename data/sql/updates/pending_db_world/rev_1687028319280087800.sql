--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 4126 AND `source_type` = 0 AND `id` = 0;
DELETE FROM `creature_template_addon` WHERE `entry` = 4126;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES (4126, 0, 0, 0, 1, 0, 0, '22766');


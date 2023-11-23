-- DB update 2023_07_16_03 -> 2023_07_17_00
-- adding the aura and making him stand as well as adding stand state for other npcs present
DELETE FROM `creature_template_addon` WHERE `entry` IN (8387, 8388, 8389, 8394);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(8387, 0, 0, 0, 0, 26, 0, ''), -- first mate
(8388, 0, 0, 0, 0, 26, 0, ''), -- cook
(8389, 0, 0, 0, 0, 26, 0, ''), -- engineer
(8394, 0, 0, 0, 0, 26, 0, '12508'); -- roland geardabbler

UPDATE `creature_template` SET `unit_class` = 8 WHERE `entry` = 8394; -- changing class from 2 to 8

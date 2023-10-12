-- DB update 2023_09_04_02 -> 2023_09_05_00
--
DELETE FROM `creature_template_addon` WHERE `entry` IN (34146, 34150, 34151);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(34146, 0, 0, 0, 0, 0, 0, '64615'),
(34150, 0, 0, 0, 0, 0, 0, '64615'),
(34151, 0, 0, 0, 0, 0, 0, '64615');

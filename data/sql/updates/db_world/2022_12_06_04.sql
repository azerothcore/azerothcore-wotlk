-- DB update 2022_12_06_03 -> 2022_12_06_04
-- 
DELETE FROM `creature_template_addon` WHERE `entry` IN (37072);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(37072, 0, 0, 0, 1, 173, 0, '');

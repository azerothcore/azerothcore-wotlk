-- DB update 2023_05_20_00 -> 2023_05_20_01
--

UPDATE `creature_addon` SET `auras` = '18950' WHERE `guid` IN (135170, 135171, 135174, 135175, 135345, 135346, 135347, 135348, 135349, 135350, 135351, 135352, 135353, 135354, 135355, 135356, 135357, 135358, 135359, 135360, 135361, 135362);

DELETE FROM `creature_template_addon` WHERE `entry` = 16408;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(16408, 0, 0, 0, 0, 0, 0, '18950');

UPDATE `creature_template_addon` SET `auras` = '18950' WHERE `entry` IN (20058, 16424);

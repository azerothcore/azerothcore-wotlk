-- DB update 2026_02_06_04 -> 2026_02_06_05
--
UPDATE `creature_template` SET `faction` = 1692 WHERE (`entry` = 22228);
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|128 WHERE (`entry` IN (19381, 22228));

DELETE FROM `creature_template_addon` WHERE (`entry` = 22228);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(22228, 0, 0, 0, 0, 0, 0, '38608');

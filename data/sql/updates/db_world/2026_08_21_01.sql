-- DB update 2026_08_21_00 -> 2026_08_21_01
-- Ulduar: Clockwork Sappers see through invisibility and stealth (retail 3.1 hotfix behavior)
UPDATE `creature_addon` SET `auras` = '18950' WHERE `guid` IN (136586, 136587, 136588, 136589, 136591, 136592);

DELETE FROM `creature_template_addon` WHERE `entry` IN (34193, 34220);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(34193, 0, 0, 0, 1, 0, 0, '18950'),
(34220, 0, 0, 0, 1, 0, 0, '18950');

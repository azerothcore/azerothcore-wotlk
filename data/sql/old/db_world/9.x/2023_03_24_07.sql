-- DB update 2023_03_24_06 -> 2023_03_24_07
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (8538, 8539)) AND (`source_type` = 0) AND (`id` IN (2));

DELETE FROM `creature_template_addon` WHERE (`entry` IN (8538, 8539));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(8538, 0, 0, 0, 1, 0, 0, '16380'),
(8539, 0, 0, 0, 1, 0, 0, '16380');

--
UPDATE `creature` SET `unit_flags` = 33587968 WHERE `id` IN (19762, 19768, 19784) AND `guid` IN (70697, 70698, 70724, 70725, 70799, 70800);

DELETE FROM `creature_addon` WHERE `guid` IN (70697, 70698, 70724, 70725, 70799, 70800);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(70697, 0, 0, 7, 1, 0, 0, NULL),
(70698, 0, 0, 7, 1, 0, 0, NULL),
(70724, 0, 0, 7, 1, 0, 0, NULL),
(70725, 0, 0, 7, 1, 0, 0, NULL),
(70799, 0, 0, 7, 1, 0, 0, NULL),
(70800, 0, 0, 7, 1, 0, 0, NULL);

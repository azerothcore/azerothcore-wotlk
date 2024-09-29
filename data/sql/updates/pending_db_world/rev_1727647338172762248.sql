--
-- visibilityDistanceType to infinite for Orgrim's Hammer and The Skybreaker marker npcs
DELETE FROM `creature_addon` WHERE (`guid` IN (134846, 134847));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(134846, 0, 0, 0, 1, 0, 5, NULL),
(134847, 0, 0, 0, 1, 0, 5, NULL);

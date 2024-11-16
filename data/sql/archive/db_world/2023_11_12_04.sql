-- DB update 2023_11_12_03 -> 2023_11_12_04
-- CREATURES SIT:
DELETE FROM `creature_addon` WHERE `guid` IN (1970898,1970880,1970879,1970878,1970894,1970895,1970896,1970927,1970877);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(1970898, 0, 0, 5, 0, 0, 0, NULL),
(1970880, 0, 0, 5, 0, 0, 0, NULL),
(1970879, 0, 0, 5, 0, 0, 0, NULL),
(1970878, 0, 0, 5, 0, 0, 0, NULL),
(1970894, 0, 0, 5, 0, 0, 0, NULL),
(1970895, 0, 0, 5, 0, 0, 0, NULL),
(1970896, 0, 0, 5, 0, 0, 0, NULL),

-- CREATURES SLEEP:
(1970927, 0, 0, 3, 0, 0, 0, NULL),
(1970877, 0, 0, 3, 0, 0, 0, NULL);

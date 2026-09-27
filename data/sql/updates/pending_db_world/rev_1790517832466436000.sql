-- --------------------------------------------------------------------------------------------
-- Durotar (Kalimdor, map 1) and Azuremyst Isle (Outland, map 530)
-- Magga (Entry 11943, GUID 3416) and Jaeleil (Entry 16476, GUID 57174)
-- Make NPCs sit
-- -------------------------------------------
DELETE FROM `creature_addon` WHERE (`guid` IN (3416, 57174));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(3416, 0, 0, 1, 1, 0, 0, NULL),
(57174, 0, 0, 1, 1, 0, 0, NULL);

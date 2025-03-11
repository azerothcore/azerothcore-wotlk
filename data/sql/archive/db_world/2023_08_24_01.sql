-- DB update 2023_08_24_00 -> 2023_08_24_01
--
SET @GUID := 137481;
DELETE FROM `creature_addon` WHERE `guid` IN (@GUID, @GUID+1, @GUID+2, @GUID+3);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@GUID, (@GUID)*10, 0, 0, 1, 0, 0, '63610'),
(@GUID+1, (@GUID+1)*10, 0, 0, 1, 0, 0, '63610'),
(@GUID+2, (@GUID+2)*10, 0, 0, 1, 0, 0, '63616'),
(@GUID+3, (@GUID+3)*10, 0, 0, 1, 0, 0, '63616');

-- DB update 2025_06_05_01 -> 2025_06_05_02
-- Link pre-spawned Ethereal Beacons to Nexus-Prince Shaffar so they respawn on reset
SET @SHAFFAR_GUID := 91162;
SET @AI_FLAGS := 1 | 2 | 8 | 16;

DELETE FROM `creature_formations` WHERE `leaderGUID` = @SHAFFAR_GUID;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@SHAFFAR_GUID, @SHAFFAR_GUID, 0, 0, @AI_FLAGS, 0, 0),
(@SHAFFAR_GUID, 91131, 0, 0, @AI_FLAGS, 0, 0),
(@SHAFFAR_GUID, 91132, 0, 0, @AI_FLAGS, 0, 0),
(@SHAFFAR_GUID, 91133, 0, 0, @AI_FLAGS, 0, 0);

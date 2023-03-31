-- DB update 2023_03_29_03 -> 2023_03_29_04
--
SET @CGUID := 138800;

DELETE FROM `creature` WHERE `id1` IN (19168, 19510) AND `map`=554 AND `guid` BETWEEN @CGUID+94 AND @CGUID+97;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+94, 19510, 554, 3849, 3849, 3, 1, 1, 274.302032470703125, -17.8063602447509765, 26.41173362731933593, 0.157079637050628662, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 43400),
(@CGUID+95, 19168, 554, 3849, 3849, 3, 1, 0, 272.1549072265625, -24.658304214477539, 26.41173171997070312, 6.161012172698974609, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 43400),
(@CGUID+96, 19510, 554, 3849, 3849, 3, 1, 1, 274.13446044921875, -28.7062282562255859, 26.41173362731933593, 0, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 43400),
(@CGUID+97, 19168, 554, 3849, 3849, 3, 1, 0, 272.077850341796875, -20.9663429260253906, 26.41172981262207031, 6.195918560028076171, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 43400);

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+94 AND `memberGUID` IN (@CGUID+94, @CGUID+95, @CGUID+96, @CGUID+97);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+94, @CGUID+94, 0, 0, 3),
(@CGUID+94, @CGUID+95, 0, 0, 3),
(@CGUID+94, @CGUID+96, 0, 0, 3),
(@CGUID+94, @CGUID+97, 0, 0, 3);

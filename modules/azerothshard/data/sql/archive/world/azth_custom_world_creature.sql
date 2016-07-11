-- low-level PvP vendor spawns
SET @GUID := 900012;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+5;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@GUID+0, 13217, 0, 0, 0, 1, 1, 0, 1, -8767.85,  418.382, 103.921, 3.64665, 300, 0, 0, 57420, 0, 0, 0, 0, 0, 0),
(@GUID+1, 15127, 0, 0, 0, 1, 1, 0, 1, -8765.48,  415.266, 103.921, 3.81863, 300, 0, 0, 52280, 0, 0, 0, 0, 0, 0),
(@GUID+2, 14753, 0, 0, 0, 1, 1, 0, 1, -8770.48,  421.691, 103.921, 3.89481, 300, 0, 0, 52280, 0, 0, 0, 0, 0, 0),
(@GUID+3, 13219, 1, 0, 0, 1, 1, 0, 1,  1646.77, -4219.27, 56.3828, 0.80658, 300, 0, 0, 57420, 0, 0, 0, 0, 0, 0),
(@GUID+4, 15126, 1, 0, 0, 1, 1, 0, 1,  1648.93, -4221.42, 56.3785, 1.00293, 300, 0, 0, 52280, 0, 0, 0, 0, 0, 0),
(@GUID+5, 14754, 1, 0, 0, 1, 1, 0, 1,  1651.95, -4222.54, 56.3789, 1.26211, 300, 0, 0, 52280, 0, 0, 0, 0, 0, 0);

-- Global auctioneer
SET @GUID := 900030;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+5;
INSERT INTO `creature` VALUES
(@GUID+0, 8661, 0, 0, 0, 1, 1, 0, 1, -8806.9, 673.122, 96.5989, 4.68813, 300, 0, 0, 6645, 0, 0, 0, 0, 0, 0),
(@GUID+1, 8661, 571, 0, 0, 1, 1, 0, 1, 5913.91, 621.969, 646.49, 1.31721, 300, 0, 0, 6645, 0, 0, 0, 0, 0, 0),
(@GUID+2, 8661, 571, 0, 0, 1, 1, 0, 1, 5698.51, 679.243, 645.816, 4.41722, 300, 0, 0, 6645, 0, 0, 0, 0, 0, 0),
(@GUID+3, 8661, 1, 0, 0, 1, 1, 0, 1, 1662.5, -4450.23, 19.5189, 0.434289, 300, 0, 0, 6645, 0, 0, 0, 0, 0, 0);

-- custom vendors
SET @GUID := 900040;

REPLACE INTO creature (guid, id , map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (@GUID+0, 1000001, 571, 1, 1, 0, 0, 5977.19, 669.417, 641.667, 3.10476, 300, 0, 0, 12600, 0, 0, 0, 0, 0);


REPLACE INTO creature (guid, id , map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (@GUID+1, 1000002, 571, 1, 1, 0, 0, 5977.07, 672.188, 641.785, 3.24928, 300, 0, 0, 12600, 0, 0, 0, 0, 0);

-- arena NPCs
SET @GUID := 900100;
-- arena 1v1
REPLACE INTO creature (guid, id , map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (@GUID+0, 1000000, 571, 1, 1, 0, 0, 5762.94, 602.368, 609.887, 0.365307, 300, 0, 0, 39099, 0, 0, 0, 0, 0);

-- arena spectator ( Shadow of Sceicco )
REPLACE INTO creature (guid, id , map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (@GUID+1, 190000, 571, 1, 1, 0, 0, 5758.1, 615.383, 609.158, 5.73193, 300, 0, 0, 42, 0, 0, 0, 0, 0);

--
-- various npc
--
SET @GUID := 901000;
-- dummy npc dalaran
INSERT INTO creature (guid, id , map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (@GUID+0, 31146, 571, 1, 1, 0, 0, 5838.72, 693.416, 609.158, 4.1539, 300, 0, 0, 24009944, 0, 0, 0, 0, 0);
-- dummy npc dalaran
INSERT INTO creature (guid, id , map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES (@GUID+1, 31146, 571, 1, 1, 0, 0, 5791.83, 656.546, 609.159, 5.31815, 300, 0, 0, 24009944, 0, 0, 0, 0, 0)

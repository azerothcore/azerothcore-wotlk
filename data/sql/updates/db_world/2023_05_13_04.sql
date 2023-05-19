-- DB update 2023_05_13_03 -> 2023_05_13_04
 
-- SQL Dark Ranger Loralen emote
DELETE FROM `creature_template_addon` WHERE (`entry` = 37779);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(37779, 0, 0, 0, 2, 0, 0, '');
-- SQL LK Boss final
DELETE FROM `creature` WHERE (`id1` = 36954);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(1972025, 36954, 0, 0, 668, 0, 0, 3, 1, 1, 5552.77, 2262.57, 733.012, 4.15523, 86400, 0, 0, 27890000, 0, 0, 0, 0, 0, '', 48999);
-- SQL LK Sylvanas final
DELETE FROM `creature` WHERE (`id1` = 37554);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(1972026, 37554, 0, 0, 668, 0, 0, 3, 1, 1, 5549.51, 2257.59, 733.011, 0.99299, 86400, 0, 0, 5040000, 881400, 0, 0, 0, 0, '', 48999);
-- Add Gossip Sylvanas Final
DELETE FROM `gossip_menu` WHERE (`MenuID` = 10931);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (10931, 15190);

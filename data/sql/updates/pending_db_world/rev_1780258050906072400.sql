-- Adjust Scarlet Champion (NPC ID 29080, GUID 129992)
-- Set Idle
-- Set Wander Dist to 0
DELETE FROM `creature` WHERE (`id1` = 29080) AND (`guid` IN (129992));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(129992, 29080, 0, 0, 609, 0, 0, 1, 4, 1, 1396.82, -5970.03, 97.1243, 6.10865, 360, 0, 0, 13495, 0, 0, 0, 0, 0, '', NULL, 0);
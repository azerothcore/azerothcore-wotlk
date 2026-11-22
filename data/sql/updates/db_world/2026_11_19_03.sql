-- DB update 2026_11_19_02 -> 2026_11_19_03

-- Add Seer Nakha Spawn Point.
DELETE FROM `creature` WHERE `id` = 23265 AND `guid` = 109724;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(109724, 23265, 530, 3518, 3613, 1, 1, 1, -1333.53, 7221.96, 33.583, 2.26893, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 48069, 1, NULL);

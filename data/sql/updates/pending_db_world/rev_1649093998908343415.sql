INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649093998908343415');

-- readjust harpy npc from being above ground and not under mesh falling to its death
DELETE FROM `creature` WHERE `guid`=51729;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(51729, 5362, 1, 0, 0, 1, 1, 0, -3090.12, 2781.57, 75.6233, 0.575489, 300, 15, 0, 2062, 1695, 1, 0, 0, 0, '', 0);

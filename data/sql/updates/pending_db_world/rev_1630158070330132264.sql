INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630158070330132264');

-- Added movement for The Husk
DELETE FROM `creature` WHERE (`id` = 1851) AND (`guid` IN (53933));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(53933, 1851, 0, 0, 0, 1, 1, 0, 0, 2325.76, -2255.95, 47.0159, 1.90398, 72000, 5, 0, 4370, 0, 1, 0, 0, 0, '', 0);

-- Set The Husk respawn to 32 hours
UPDATE `creature` SET `spawntimesecs` = 115200 WHERE `id` = 1851 AND `guid` = 53933;

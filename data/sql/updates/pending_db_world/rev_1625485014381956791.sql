INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625485014381956791');

-- Relocate Dread Swoop
DELETE FROM `creature` WHERE `id` = 4692 AND `guid` = 27980;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(27980, 4692, 1, 0, 0, 1, 1, 1192, 0, 52.892, 1563.021, 124.512, 3.459, 300, 3, 0, 1163, 0, 1, 0, 0, 0, '', 0);

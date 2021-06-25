INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624633710255818800');

DELETE FROM `creature` WHERE (`id` = 2351) AND (`guid` IN (15226));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(15226, 2351, 0, 0, 0, 1, 1, 806, 0, 216.317, -991.876, 77.72, 3.22886, 300, 5, 0, 677, 0, 1, 0, 0, 0, '', 0);
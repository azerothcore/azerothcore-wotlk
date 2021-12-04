INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638646536763994700');

/* Fix LK Positioning in last phase of Scarlet Enclave
*/

DELETE FROM `creature` WHERE (`id` = 29110);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(130896, 29110, 609, 0, 0, 1, 192, 0, 0, 2310.64, -5742.08, 161.3, 3.85123, 360, 0, 0, 27890000, 0, 0, 0, 0, 0, '', 0);


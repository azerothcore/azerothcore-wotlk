INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613367143020390000');

/* Quest 'The Attack!' Improvements
*/

DELETE FROM `creature` WHERE `id` = 7779;

/*  Not part of 'The Attack!', but in the same area - NPC was stuck in the wall
*/

DELETE FROM `creature` WHERE (`id` = 24729) AND (`guid` IN (49591));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(49591, 24729, 0, 0, 0, 1, 1, 344, 0, -8406.450195, 482.553864, 123.759903, 1.84221, 180, 3, 0, 8982, 0, 1, 0, 0, 0, '', 0);

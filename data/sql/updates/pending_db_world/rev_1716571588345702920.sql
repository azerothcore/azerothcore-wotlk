--
DELETE FROM `creature` WHERE `id1` = 33742;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136768, 33742, 0, 0, 603, 0, 0, 3, 1, 0, 1809.87, -38.245, 408.037, 0, 180, 0, 0, 26066, 0, 0, 0, 0, 0, '', 0);
UPDATE `creature_template` SET `ScriptName` = 'boss_kologarn_pit_kill_bunny' WHERE `entry` = 33742;

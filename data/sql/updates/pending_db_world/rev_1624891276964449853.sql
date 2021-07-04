INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624891276964449853');

-- Accursed Slitherblade 14229, GUID 51846 - MovementType to 1, wander dist to 20
UPDATE `creature_template` SET `movementId` = 1 WHERE `entry` = 14229;
DELETE FROM `creature` WHERE `id` = 14229 AND `guid` = 51846;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51846, 14229, 1, 0, 0, 1, 1, 0, 0, -117.75, 2337.5, -24.0244, 6.12535, 9900, 20, 0, 1342, 0, 1, 0, 0, 0, '', 0);

-- Giggler - 14228, GUID 51847 - MovementType to 1, wander dist to 5
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` = 14228;
DELETE FROM `creature` WHERE `id` = 14228 AND `guid` = 51847;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(51847, 14228, 1, 0, 0, 1, 1, 0, 0, -414.566, 1477.82, 90.7611, 4.68571, 9900, 5, 0, 1279, 0, 1, 0, 0, 0, '', 0);

-- Normalize Giggler speed (was 2.12)
UPDATE `creature_template` SET `speed_walk` = 1 WHERE `entry` = 14228;

-- Crusty - 18241, GUID 27825 -  MovementType to 1, wander dist to 20
UPDATE `creature_template` SET `MovementType` = 1 WHERE `entry` = 18241;
DELETE FROM `creature` WHERE `id` = 18241 AND `guid` = 27825;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(27825, 18241, 1, 0, 0, 1, 1, 17625, 0, -100.613, 2832.51, -40.6645, 3.98299, 21600, 20, 0, 955, 0, 1, 0, 0, 0, '', 0);


INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627733875042202000');

-- Added movement for Lord Maldazzar spawns
UPDATE `creature_template` SET `MovementType` = 1 WHERE (`entry` = 1848);
UPDATE `creature` SET `wander_distance` = 10, `MovementType` = 1 WHERE (`id` = 1848) AND (`guid` IN (52725));

-- Add new spawn point near the inn
DELETE FROM `creature` WHERE (`guid` = 152292);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(152292, 1848, 0, 0, 0, 1, 1, 0, 1, 1123.73, -1714.49, 62.33, 0, 86400, 5, 0, 1, 0, 1, 0, 0, 0, '', 0); --  Near inn in Sorrow hill

-- Added his spawns pto the same pool so there can be only 1 Lord Maldazzar active at the same time
DELETE FROM `pool_template` WHERE `entry` = 368;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (368, 1, "Lord Maldazzar Spawns");

DELETE FROM `pool_creature` WHERE `guid` IN (52725, 152292);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(52725, 368, 0, "Lord Maldazzar Spawn Crypt"),
(152292, 368, 0, "Lord Maldazzar Spawn Inn Sorrow hill");


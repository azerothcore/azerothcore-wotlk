INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630227596211930942');

-- Add new spawn and add roaming around to Zul'arek Hatefowler
UPDATE `creature_template` SET `MovementType` = 1 WHERE (`entry` = 8219);

-- Add new spawn and changed the spawn time from 20h to 6h
DELETE FROM `creature` WHERE (`id` = 8219) AND `guid` IN (86257, 138255);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(86257, 8219, 0, 0, 0, 1, 1, 0, 1, 6.16813, -2823.02, 120.508, 4.36383, 21600, 10, 0, 2059, 0, 1, 0, 0, 0, '', 0),
(138255, 8219, 0, 0, 0, 1, 1, 0, 1, -85.21, -2524.166, 120.508, 120.27, 21600, 10, 0, 2059, 0, 1, 0, 0, 0, '', 0);

-- Add the new spawn to the same spawn pool so he can only be spawned once at a time
DELETE FROM `pool_template` WHERE `entry` = 372;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (372, 1, "Zul'arek Hatefowler Spawns");

DELETE FROM `pool_creature` WHERE `guid` IN (86257, 138255);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(86257, 372, 0, "Zul'arek Hatefowler Spawn 1"),
(138255, 372, 0, "Zul'arek Hatefowler Spawn 2");

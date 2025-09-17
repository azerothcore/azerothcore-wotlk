-- DB update 2025_09_16_06 -> 2025_09_17_00
--
DELETE FROM `creature` WHERE `guid` = 117222 AND `id1` = 26335;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(117222, 26335, 571, 394, 4221, 1, 1, 0, 4706.6416015625, -4453.7060546875, 195.04803466796875, 1.972222089767456054, 120, 0, 0, 1, 852, 0, 0, 0, 0, 63163);

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|256|512, `RegenHealth` = 0 WHERE `entry` = 26335;

DELETE FROM `creature_addon` WHERE `guid` = 117222;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(117222, 0, 0, 7, 0, 0, 0, '');

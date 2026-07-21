-- Spawn Voice of Yogg-Saron in Ulduar (spawn data from TrinityCore)
DELETE FROM `creature` WHERE `id` = 33280 AND `map` = 603;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(62015, 33280, 603, 0, 0, 3, 1, 0, 1980.14, -25.7438, 326.467, 0, 604800, 0, 0, '', 'Voice of Yogg-Saron', 0);

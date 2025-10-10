-- DB update 2025_10_04_00 -> 2025_10_04_01
-- Update gameobject 'Stolen Pack' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (191726)) AND (`guid` IN (42));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(42, 191726, 571, 0, 0, 1, 1, 7312.4150390625, -1610.486572265625, 944.2940673828125, 4.991643905639648437, 0, 0, -0.60181427001953125, 0.798636078834533691, 120, 255, 1, "", 47720, NULL);

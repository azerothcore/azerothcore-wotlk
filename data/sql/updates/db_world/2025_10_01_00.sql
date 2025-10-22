-- DB update 2025_09_30_02 -> 2025_10_01_00
-- Update gameobject '186957' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (186957)) AND (`guid` IN (65654));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(65654, 186957, 571, 0, 0, 1, 1, 514.50347900390625, -5936.9287109375, 313.857574462890625, 3.141527414321899414, -0.02631568908691406, 0.036975860595703125, 0.998969078063964843, 0.001006617560051381, 120, 255, 0, "", 48632, NULL);

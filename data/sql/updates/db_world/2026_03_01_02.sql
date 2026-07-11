-- DB update 2026_03_01_01 -> 2026_03_01_02
-- Update gameobject 'Black Smoke - scale 2' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (965)) AND (`guid` IN (195, 196));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(195, 965, 0, 0, 0, 1, 1, -10295.9267578125, 73.21956634521484375, 44.2343597412109375, 0, 0, 0, 0, 1, 120, 255, 1, "", 48632, NULL),
(196, 965, 0, 0, 0, 1, 1, 263.2623291015625, -267.665374755859375, 145.0235137939453125, 4.572763919830322265, 0, 0, -0.75470924377441406, 0.656059443950653076, 120, 255, 1, "", 49822, NULL);

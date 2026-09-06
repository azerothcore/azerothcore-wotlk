-- DB update 2025_10_09_01 -> 2025_10_09_02
-- Update gameobject 'Frostglow' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (192077)) AND (`guid` IN (46));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(46, 192077, 571, 0, 0, 1, 8, 7214.13720703125, -2652.241455078125, 820.3399658203125, 0.24434557557106018, 0, 0, 0.121869087219238281, 0.9925462007522583, 120, 255, 1, "", 46248, NULL);

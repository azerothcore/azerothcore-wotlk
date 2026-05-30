-- DB update 2026_02_28_09 -> 2026_03_01_00
-- Update gameobject 'Thunder Ale' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (369)) AND (`guid` IN (55));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(55, 369, 0, 0, 0, 1, 1, -5603.8203125, -532.54766845703125, 400.622222900390625, 0.174532130360603332, 0, 0, 0.087155342102050781, 0.996194720268249511, 120, 255, 1, "", 50664, NULL);

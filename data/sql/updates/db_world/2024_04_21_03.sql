-- DB update 2024_04_21_02 -> 2024_04_21_03
-- Update gameobject 'A Dusty Tome' with sniffed values

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (179548))
AND (`guid` IN (20));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(20, 179548, 429, 0, 0, 1, 1, 4.497807025909423828, -437.5672607421875, 16.41251754760742187, 4.136432647705078125, 0, 0, -0.87881660461425781, 0.477159708738327026, 7200, 255, 1, "", 52237, NULL);

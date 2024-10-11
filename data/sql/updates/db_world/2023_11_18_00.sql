-- DB update 2023_11_17_04 -> 2023_11_18_00
-- Update gameobject 187914 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187914) AND (`guid` IN (76314));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76314, 187914, 0, 0, 0, 1, 1, -1211.6009521484375, -2676.880615234375, 45.36121749877929687, 5.637413978576660156, 0, 0, -0.31730461120605468, 0.948323667049407958, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76314));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76314);

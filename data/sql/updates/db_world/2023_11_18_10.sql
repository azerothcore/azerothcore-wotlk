-- DB update 2023_11_18_09 -> 2023_11_18_10
-- Update gameobject 187933 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187933) AND (`guid` IN (76349));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76349, 187933, 530, 0, 0, 1, 1, -2526.489501953125, 7551.50634765625, -2.35202503204345703, 2.146752834320068359, 0, 0, 0.878816604614257812, 0.477159708738327026, 120, 255, 1, "", 50172, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76349));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76349);

-- DB update 2023_11_18_00 -> 2023_11_18_01
-- Update gameobject 187916 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187916) AND (`guid` IN (76339));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76339, 187916, 1, 0, 0, 1, 1, 2558.728759765625, -481.665863037109375, 109.8209762573242187, 3.804818391799926757, 0, 0, -0.94551849365234375, 0.325568377971649169, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76339));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76339);

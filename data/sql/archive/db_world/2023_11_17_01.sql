-- DB update 2023_11_17_00 -> 2023_11_17_01
-- Update gameobject 187564 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187564) AND (`guid` IN (76304));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76304, 187564, 0, 0, 0, 1, 1, -10657.0830078125, 1054.6292724609375, 32.67332077026367187, 2.478367090225219726, 0, 0, 0.94551849365234375, 0.325568377971649169, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76304));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76304);

-- DB update 2023_11_18_01 -> 2023_11_18_02
-- Update gameobject 187934 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187934) AND (`guid` IN (76306));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76306, 187934, 0, 0, 0, 1, 1, -9434.296875, -2110.36279296875, 65.803802490234375, 0.349065244197845458, 0, 0, 0.173647880554199218, 0.984807789325714111, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76306));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76306);

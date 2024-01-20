-- DB update 2023_11_18_11 -> 2023_11_18_12
-- Update gameobject 187923 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187923) AND (`guid` IN (76340));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76340, 187923, 1, 0, 0, 1, 1, 6327.68212890625, 512.60986328125, 17.47229766845703125, 0.034906249493360519, 0, 0, 0.017452239990234375, 0.999847710132598876, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76340));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76340);

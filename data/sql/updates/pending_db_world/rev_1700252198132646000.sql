-- Update gameobject 187922 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187922) AND (`guid` IN (76308));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76308, 187922, 0, 0, 0, 1, 1, -8249.5283203125, -2625.9853515625, 133.1546478271484375, 1.727874636650085449, 0, 0, 0.760405540466308593, 0.649448513984680175, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76308));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76308);
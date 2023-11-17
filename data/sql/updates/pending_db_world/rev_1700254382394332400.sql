-- Update gameobject 187929 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187929) AND (`guid` IN (76329));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76329, 187929, 1, 0, 0, 1, 1, -4401.17041015625, 3484.65185546875, 12.17616653442382812, 2.460912704467773437, 0, 0, 0.942641258239746093, 0.333807557821273803, 120, 255, 1, "", 50172, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76329));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76329);
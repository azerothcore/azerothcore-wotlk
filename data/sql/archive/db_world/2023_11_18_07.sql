-- DB update 2023_11_18_06 -> 2023_11_18_07
-- Update gameobject 187919 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187919) AND (`guid` IN (76356));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76356, 187919, 530, 0, 0, 1, 1, 2019.80322265625, 6580.18603515625, 134.36187744140625, 1.937312245368957519, 0, 0, 0.824125289916992187, 0.566407561302185058, 120, 255, 1, "", 50172, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76356));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76356);

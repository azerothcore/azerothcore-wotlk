INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1604442802893059360');

DELETE FROM `game_event_gameobject` WHERE `guid` IN (150747);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES (-12,150747);

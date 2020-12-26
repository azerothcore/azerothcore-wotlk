INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1608597053624009600');

DELETE FROM `game_event_gameobject` WHERE `guid` IN (59177, 59178);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(24, 59177),
(24, 59178);

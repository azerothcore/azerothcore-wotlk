INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645520412284756500');

DELETE FROM `game_event_creature` WHERE `guid` = 146623;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(8, 146623);

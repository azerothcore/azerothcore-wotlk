INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638733140143862200');

DELETE FROM `game_event_creature` WHERE `eventEntry` = 24 AND `guid` = 24;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(2, 24);

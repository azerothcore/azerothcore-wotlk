INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618438031594589517');

DELETE FROM `game_event_creature` WHERE `guid`=137686 AND `eventEntry`=5;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(5, 137686);

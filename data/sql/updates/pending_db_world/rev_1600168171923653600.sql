INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1600168171923653600');

DELETE FROM `game_event` WHERE `eventEntry` = 24;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES 
(24, '2017-09-20 01:01:00', '2030-12-31 07:00:00', 525600, 21600, 372, 2, 'Brewfest', 0, 2);

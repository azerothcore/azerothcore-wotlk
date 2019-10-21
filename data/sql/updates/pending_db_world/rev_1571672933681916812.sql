INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1571672933681916812');

UPDATE `game_event` SET `start_time` = '1970-01-01 08:00:00', `end_time` = '1970-01-01 08:00:00' WHERE `eventEntry` IN
(13, 17, 22, 31, 48, 49, 55, 56, 57, 58, 59, 60, 65, 66);

UPDATE `game_event` SET `end_time` = NULL WHERE `eventEntry` IN
(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 18, 
19, 20, 21, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 
37, 38, 39, 40, 41, 42, 43, 44, 45, 50, 51, 52, 53, 54, 62, 63, 
64, 67, 68, 69, 70, 71);

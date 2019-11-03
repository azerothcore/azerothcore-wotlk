INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1572815191193825836');

UPDATE `worldstates` SET `comment`='NextDailyQuestResetTime' WHERE `entry`=20005;
DELETE FROM `worldstates` WHERE `entry`=20004;
INSERT INTO `worldstates` (`entry`, `value`, `comment`) VALUES(20004, 0, 'cleaning_flags');

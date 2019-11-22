INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1572030074009407852');

UPDATE `worldstates` SET `comment`='NextArenaPointDistributionTime' WHERE `entry`=20001;
UPDATE `worldstates` SET `comment`='NextWeeklyQuestResetTime' WHERE `entry`=20002;
UPDATE `worldstates` SET `comment`='NextBGRandomDailyResetTime' WHERE `entry`=20003;
UPDATE `worldstates` SET `comment`='cleaning_flags' WHERE `entry`=20005;
UPDATE `worldstates` SET `comment`='NextGuildDailyResetTime' WHERE `entry`=20006;
UPDATE `worldstates` SET `comment`='NextMonthlyQuestResetTime' WHERE `entry`=20007;

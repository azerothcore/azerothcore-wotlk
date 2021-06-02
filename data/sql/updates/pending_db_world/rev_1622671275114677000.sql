INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622671275114677000');

SET @ANNOUNCE = 14;
SET @FISHING_POOLS = 15;
SET @TURN_INS = 62;
UPDATE `game_event` SET `start_time` = '2016-10-29 00:00:00' WHERE `eventEntry` = @ANNOUNCE;
UPDATE `game_event` SET `start_time` = '2016-10-30 14:00:00' WHERE `eventEntry` IN (@FISHING_POOLS, @TURN_INS);

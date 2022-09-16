-- DB update 2022_01_12_03 -> 2022_01_12_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_12_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_12_03 2022_01_12_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641654057632672300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641654057632672300');

UPDATE `game_event` SET `start_time`='2021-06-22 00:01:00' WHERE `eventEntry`=1;
UPDATE `game_event` SET `start_time`='2021-12-16 01:00:00' WHERE `eventEntry`=2;
UPDATE `game_event` SET `start_time`='2021-01-01 07:00:00' WHERE `eventEntry`=6;
UPDATE `game_event` SET `start_time`='2021-01-24 00:01:00' WHERE `eventEntry`=7;
UPDATE `game_event` SET `start_time`='2021-02-08 00:01:00' WHERE `eventEntry`=8;
UPDATE `game_event` SET `start_time`='2021-04-13 00:01:00' WHERE `eventEntry`=9;
UPDATE `game_event` SET `start_time`='2021-05-01 00:01:00' WHERE `eventEntry`=10;
UPDATE `game_event` SET `start_time`='2021-09-29 00:01:00' WHERE `eventEntry`=11;
UPDATE `game_event` SET `start_time`='2021-10-19 00:00:00' WHERE `eventEntry`=12;
UPDATE `game_event` SET `start_time`='2021-09-20 01:01:00' WHERE `eventEntry`=24;
UPDATE `game_event` SET `start_time`='2021-11-23 01:00:00' WHERE `eventEntry`=26;
UPDATE `game_event` SET `start_time`='2021-10-01 00:01:00' WHERE `eventEntry`=34;
UPDATE `game_event` SET `start_time`='2021-11-01 00:01:00' WHERE `eventEntry`=35;
UPDATE `game_event` SET `start_time`='2021-12-01 00:01:00' WHERE `eventEntry`=36;
UPDATE `game_event` SET `start_time`='2021-01-01 00:01:00' WHERE `eventEntry`=37;
UPDATE `game_event` SET `start_time`='2021-02-01 00:01:00' WHERE `eventEntry`=38;
UPDATE `game_event` SET `start_time`='2021-03-01 00:01:00' WHERE `eventEntry`=39;
UPDATE `game_event` SET `start_time`='2021-04-01 00:01:00' WHERE `eventEntry`=40;
UPDATE `game_event` SET `start_time`='2021-05-01 00:01:00' WHERE `eventEntry`=41;
UPDATE `game_event` SET `start_time`='2021-06-01 00:01:00' WHERE `eventEntry`=42;
UPDATE `game_event` SET `start_time`='2021-07-01 00:01:00' WHERE `eventEntry`=43;
UPDATE `game_event` SET `start_time`='2021-08-01 00:01:00' WHERE `eventEntry`=44;
UPDATE `game_event` SET `start_time`='2021-09-01 00:01:00' WHERE `eventEntry`=45;
UPDATE `game_event` SET `start_time`='2021-09-19 01:01:00' WHERE `eventEntry`=50;
UPDATE `game_event` SET `start_time`='2021-11-01 02:00:00' WHERE `eventEntry`=51;
UPDATE `game_event` SET `start_time`='2021-12-25 06:00:00' WHERE `eventEntry`=52;
UPDATE `game_event` SET `start_time`='2021-09-20 01:01:00' WHERE `eventEntry`=70;
UPDATE `game_event` SET `start_time`='2021-03-20 07:00:00' WHERE `eventEntry`=78;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_12_04' WHERE sql_rev = '1641654057632672300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- DB update 2019_01_08_00 -> 2019_01_08_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_08_00 2019_01_08_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1546538959760274673'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1546538959760274673');

ALTER TABLE `game_event`
ADD COLUMN `announce` tinyint(3) unsigned NOT NULL DEFAULT 2 COMMENT '0 dont announce, 1 announce, 2 value from config' AFTER `world_event`;

ALTER TABLE `game_event`
  CHANGE `start_time` `start_time` TIMESTAMP NULL DEFAULT NULL COMMENT 'Absolute start date, the event will never start before',
  CHANGE `end_time` `end_time` TIMESTAMP NULL DEFAULT NULL COMMENT 'Absolute end date, the event will never start after';

UPDATE IGNORE `game_event` SET `start_time`=NULL WHERE `start_time`='0000-00-00 00:00:00';
UPDATE IGNORE `game_event` SET `end_time`=NULL WHERE `end_time`='0000-00-00 00:00:00';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

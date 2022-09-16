-- DB update 2019_06_20_00 -> 2019_06_20_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_20_00 2019_06_20_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1560521436127285100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1560521436127285100');

UPDATE `smart_scripts` SET `event_param1` = 0, `event_param2` = 0, `action_param2` = 1, `comment` = 'Venture Co. Strip Miner - In Combat - Cast Throw Dynamite' WHERE `entryorguid` = 674 AND `source_type` = 0 and `id` = 0;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

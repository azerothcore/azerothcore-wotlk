-- DB update 2021_12_07_11 -> 2021_12_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_07_11';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_07_11 2021_12_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638737032167850775'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638737032167850775');

-- Makes quest Lazy Peon broadcast work work only from themselves and not the player (action_para2)
-- Sets it up where the target_type is the player and only triggers with in 20 yards
UPDATE `smart_scripts` SET `action_param2`=1, `target_type`=18, `target_param1`=20 WHERE  `comment`='Lazy Peon - On Script - Play Sound 6197';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_08_00' WHERE sql_rev = '1638737032167850775';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

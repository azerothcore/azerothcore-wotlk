-- DB update 2021_07_23_03 -> 2021_07_23_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_03 2021_07_23_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626683624183921600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626683624183921600');

-- Changed the param WP_START run from 1 to 0 so he walks when the quest starts.
UPDATE `smart_scripts` SET `action_param1` = 0 WHERE (`entryorguid` = 1379) AND (`source_type` = 0) AND (`id` IN (0));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_04' WHERE sql_rev = '1626683624183921600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

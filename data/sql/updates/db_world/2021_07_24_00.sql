-- DB update 2021_07_23_18 -> 2021_07_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_18';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_18 2021_07_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626804070827928100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626804070827928100');

-- Changed the param of the shadow bolt so it will stop any spells being casted at the moment
UPDATE `smart_scripts` SET `action_param2` = 1 WHERE (`entryorguid` = 2590) AND (`source_type` = 0) AND (`id` IN (2));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_24_00' WHERE sql_rev = '1626804070827928100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

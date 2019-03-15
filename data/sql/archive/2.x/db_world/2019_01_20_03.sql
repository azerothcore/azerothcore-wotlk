-- DB update 2019_01_20_02 -> 2019_01_20_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_20_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_20_02 2019_01_20_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1547942801355864450'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547942801355864450');

-- SMART_ACTION_SET_SIGHT_DIST
UPDATE `smart_scripts` SET `action_type` = 121 WHERE `action_type` = 136;

-- SMART_ACTION_FLEE
UPDATE `smart_scripts` SET `action_type` = 122 WHERE `action_type` = 137;

-- SMART_ACTION_ADD_THREAT
UPDATE `smart_scripts` SET `action_type` = 123 WHERE `action_type` = 138;

-- SMART_ACTION_LOAD_EQUIPMENT
UPDATE `smart_scripts` SET `action_type` = 124 WHERE `action_type` = 139;

-- SMART_ACTION_TRIGGER_RANDOM_TIMED_EVENT
UPDATE `smart_scripts` SET `action_type` = 125 WHERE `action_type` = 140;

-- SMART_ACTION_REMOVE_ALL_GAMEOBJECTS
UPDATE `smart_scripts` SET `action_type` = 126 WHERE `action_type` = 146;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

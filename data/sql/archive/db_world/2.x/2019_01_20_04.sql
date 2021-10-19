-- DB update 2019_01_20_03 -> 2019_01_20_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_20_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_20_03 2019_01_20_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1547990516486417003'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547990516486417003');


-- SMART_ACTION_MOVE_TO_POS_TARGET
UPDATE `smart_scripts` SET `action_type` = 201 WHERE `action_type` = 130;

-- SMART_ACTION_SET_GO_STATE
UPDATE `smart_scripts` SET `action_type` = 202 WHERE `action_type` = 131;

-- SMART_ACTION_EXIT_VEHICLE
UPDATE `smart_scripts` SET `action_type` = 203 WHERE `action_type` = 132;

-- SMART_ACTION_SET_UNIT_MOVEMENT_FLAGS
UPDATE `smart_scripts` SET `action_type` = 204 WHERE `action_type` = 133;

-- SMART_ACTION_SET_COMBAT_DISTANCE
UPDATE `smart_scripts` SET `action_type` = 205 WHERE `action_type` = 134;

-- SMART_ACTION_SET_CASTER_COMBAT_DIST
UPDATE `smart_scripts` SET `action_type` = 206 WHERE `action_type` = 135;

-- SMART_ACTION_SET_HOVER
UPDATE `smart_scripts` SET `action_type` = 207 WHERE `action_type` = 141;

-- SMART_ACTION_ADD_IMMUNITY
UPDATE `smart_scripts` SET `action_type` = 208 WHERE `action_type` = 142;

-- SMART_ACTION_REMOVE_IMMUNITY
UPDATE `smart_scripts` SET `action_type` = 209 WHERE `action_type` = 143;

-- SMART_ACTION_FALL
UPDATE `smart_scripts` SET `action_type` = 210 WHERE `action_type` = 144;

-- SMART_ACTION_SET_EVENT_FLAG_RESET
UPDATE `smart_scripts` SET `action_type` = 211 WHERE `action_type` = 145;

-- SMART_ACTION_STOP_MOTION
UPDATE `smart_scripts` SET `action_type` = 212 WHERE `action_type` = 147;

-- SMART_ACTION_NO_ENVIRONMENT_UPDATE
UPDATE `smart_scripts` SET `action_type` = 213 WHERE `action_type` = 148;

-- SMART_ACTION_ZONE_UNDER_ATTACK
UPDATE `smart_scripts` SET `action_type` = 214 WHERE `action_type` = 149;

-- SMART_ACTION_LOAD_GRID
UPDATE `smart_scripts` SET `action_type` = 215 WHERE `action_type` = 150;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

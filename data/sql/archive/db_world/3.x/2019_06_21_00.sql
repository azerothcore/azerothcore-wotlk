-- DB update 2019_06_20_01 -> 2019_06_21_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_20_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_20_01 2019_06_21_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1560292934254034937'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1560292934254034937');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31318;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 31318 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(31318,0,0,0,54,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,23,0,0,0,0,0,0,0,0,'Death Knight Adept - On Just Summoned - Start Attack Owner'),
(31318,0,1,0,6,0,100,0,0,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Death Knight Adept - On Death - Force Despawn After 5 Seconds');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 31316 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(31316,0,0,1,25,0,100,0,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ebon Blade Reaper - On Reset - Set Defensive'),
(31316,0,1,0,61,0,100,0,0,0,0,0,0,67,1,5000,10000,0,0,0,1,0,0,0,0,0,0,0,0,'Ebon Blade Reaper - Linked - Create Timed Event ID 1'),
(31316,0,2,0,59,0,100,0,1,0,0,0,0,11,58962,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ebon Blade Reaper - On Timed Event ID 1 - Cast Summon Death Knight Adept');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

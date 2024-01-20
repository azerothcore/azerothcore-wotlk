-- DB update 2020_05_21_00 -> 2020_05_21_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_21_00 2020_05_21_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590099720339762700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590099720339762700');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=25623;

DELETE FROM `smart_scripts` WHERE `entryorguid`=25623 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25623, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 4000, 6000, 11, 54185, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Harvest Collector - IC - Cast Claw Slash'),
(25623, 0, 1, 0, 8, 0, 100, 0, 47166, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harvest Collector - On spell hit - Despawn');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

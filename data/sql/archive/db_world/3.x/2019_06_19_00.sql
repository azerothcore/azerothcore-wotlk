-- DB update 2019_06_18_00 -> 2019_06_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_18_00 2019_06_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1560028006349950800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1560028006349950800');

-- Sporebat SAI (18128)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18128; 
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18128);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18128, 0, 0, 0, 6, 0, 75, 1, 0, 0, 0, 0, 0, 11, 35336, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sporebat - On Just Died - Cast \'Energizing Spores\' (Phase 1) (No Repeat)'),
(18128, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 15000, 15000, 0, 11, 35394, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sporebat - In Combat - Cast \'Spore Cloud\' (Phase 1) (No Repeat)');

-- Greater Sporebat SAI (18129)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18129; 
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18129);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18129, 0, 0, 0, 6, 0, 75, 1, 0, 0, 0, 0, 0, 11, 35336, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greater Sporebat - On Just Died - Cast \'Energizing Spores\' (Phase 1) (No Repeat)'),
(18129, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 15000, 15000, 0, 11, 35394, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greater Sporebat - In Combat - Cast \'Spore Cloud\' (Phase 1) (No Repeat)');

--  Young Sporebat SAI (20387)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20387; 
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20387);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20387, 0, 0, 0, 6, 0, 75, 1, 0, 0, 0, 0, 0, 11, 35336, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Young Sporebat - On Just Died - Cast \'Energizing Spores\' (No Repeat)');

-- Sporewing SAI (18280)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18280; 
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18280);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18280, 0, 0, 0, 6, 0, 75, 1, 0, 0, 0, 0, 0, 11, 35336, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sporewing - On Just Died - Cast \'Energizing Spores\''),
(18280, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 15000, 15000, 0, 11, 35394, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sporewing - In Combat - Cast \'Spore Cloud\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

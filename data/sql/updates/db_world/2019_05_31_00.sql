-- DB update 2019_05_29_00 -> 2019_05_31_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_29_00 2019_05_31_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558744539335597800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558744539335597800');

-- Wastewalker Slave SAI (17963)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17963; 
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17963);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17963, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 900000, 900000, 0, 11, 34880, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - Out of Combat - Cast Elemental Armor'),
(17963, 0, 1, 0, 0, 0, 100, 2, 6000, 7700, 19000, 21000, 0, 11, 32192, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frost Nova'),
(17963, 0, 2, 0, 0, 0, 100, 4, 6000, 7700, 19000, 21000, 0, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frost Nova'),
(17963, 0, 3, 0, 0, 0, 100, 2, 1300, 3700, 5000, 8000, 0, 11, 15497, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frostbolt'),
(17963, 0, 4, 0, 0, 0, 100, 4, 1300, 3700, 5000, 8000, 0, 11, 12675, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - In Combat - Cast Frostbolt'),
(17963, 0, 5, 6, 38, 0, 100, 0, 1, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 63.3, -58.76, -1.5, 0, 'Wastewalker Slave - On Data Set - Move Point'),
(17963, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - On Data Set - Despawn'),
(17963, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - On Data Set - Say Line 0'),
(17963, 0, 8, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - On Data Set - Attack Start'),
(17963, 0, 9, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Slave - On Data Set - Stop Combat');

-- Wastewalker Worker SAI (17964)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17964; 
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17964);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17964, 0, 0, 0, 0, 0, 100, 2, 2300, 7700, 9000, 11000, 0, 11, 13738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - In Combat - Cast Rend'),
(17964, 0, 1, 0, 0, 0, 100, 4, 2300, 7700, 9000, 11000, 0, 11, 37662, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - In Combat - Cast Rend'),
(17964, 0, 2, 3, 38, 0, 100, 0, 1, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 63.3, -58.76, -1.5, 0, 'Wastewalker Worker - On Data Set - Move Point'),
(17964, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - On Data Set - Despawn'),
(17964, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - On Data Set - Say Line 0'),
(17964, 0, 5, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - On Data Set - Attack Start'),
(17964, 0, 6, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewalker Worker - On Data Set - Stop Combat');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

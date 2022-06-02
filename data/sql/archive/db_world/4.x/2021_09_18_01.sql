-- DB update 2021_09_18_00 -> 2021_09_18_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_18_00 2021_09_18_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1616252599323979000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616252599323979000');
/*
 * Zone: Terokkar Forest
 * Update by Knindza | <www.azerothcore.org>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21787;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21787);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21787, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 16592, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - On Respawn - Cast \'16592\' (No Repeat)'),
(21787, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 11639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - On Aggro - Cast \'11639\' (No Repeat)'),
(21787, 0, 2, 0, 0, 0, 100, 0, 2300, 3000, 7800, 9000, 11, 9734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - In Combat - Cast \'9734\''),
(21787, 0, 3, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 42420, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis High Priest - Between 10-30% Health - Cast \'42420\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21644;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21644);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21644, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 30000, 31000, 11, 13730, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skettis Wing Guard - In Combat - Cast \'13730\''),
(21644, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 20000, 25000, 11, 35321, 33, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skettis Wing Guard - In Combat - Cast \'35321\''),
(21644, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 40546, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skettis Wing Guard - Between 20-80% Health - Cast \'40546\' (No Repeat)'),
(21644, 0, 3, 4, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skettis Wing Guard - Between 5-30% Health - Cast \'8599\' (No Repeat)'),
(21644, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skettis Wing Guard - Between 5-30% Health - Say Line 0 (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21912;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21912);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21912, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 37577, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skettis Sentinel - In Combat - Cast \'37577\''),
(21912, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 30619, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skettis Sentinel - Between 20-80% Health - Cast \'30619\' (No Repeat)'),
(21912, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 23537, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skettis Sentinel - Between 5-30% Health - Cast \'23537\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21652;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21652);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21652, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 37589, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skettis Time-Shifter - On Aggro - Cast \'37589\' (No Repeat)'),
(21652, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 8500, 10000, 11, 16006, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skettis Time-Shifter - In Combat - Cast \'16006\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21651;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21651);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21651, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 42247, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - On Aggro - Cast \'42247\' (No Repeat)'),
(21651, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - In Combat - Cast \'15496\''),
(21651, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 3019, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Skettis Reaver - Between 5-30% Health - Cast \'3019\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18595;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18595);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18595, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warped Peon - Between 5-30% Health - Flee For Assist (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21636;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 21636);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21636, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Draenei - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22045;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22045);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22045, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 38621, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Husk - In Combat - Cast \'38621\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18449;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18449);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18449, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 29651, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shienor Talonite - On Respawn - Cast \'29651\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22265;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 22265);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17128, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 20000, 25000, 11, 30285, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowwing Owl - In Combat - Cast \'30285\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_18_01' WHERE sql_rev = '1616252599323979000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- DB update 2020_08_26_02 -> 2020_08_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_26_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_26_02 2020_08_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1596557280688269900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596557280688269900');
/*
 * Zone: Tanaris
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9396;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9396);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9396, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 6524, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ground Pounder - Between 30-60% Health - Cast \'6524\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5428;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5428);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5428, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Roc - Between 20-80% Health - Cast \'5708\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5422;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5422);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5422, 0, 0, 0, 0, 0, 100, 0, 2100, 2700, 25300, 28000, 11, 7992, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scorpid Hunter - In Combat - Cast \'7992\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5425;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5425);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5425, 0, 0, 0, 0, 0, 100, 0, 1700, 2400, 9800, 12600, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Starving Blisterpaw - In Combat - Cast \'3604\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14123;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14123);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14123, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 26064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Steeljaw Snapper - Between 20-80% Health - Cast \'26064\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7883;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7883);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7883, 0, 0, 0, 0, 0, 100, 0, 1700, 2300, 8600, 9400, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Andre Firebeard - In Combat - Cast \'5679\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8196;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8196);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8196, 0, 0, 0, 0, 0, 100, 0, 2700, 3200, 10500, 11600, 11, 10833, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Occulus - In Combat - Cast \'10833\''),
(8196, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 20717, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Occulus - Between 40-80% Health - Cast \'20717\' (No Repeat)'),
(8196, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 18144, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Occulus - Between 10-30% Health - Cast \'18144\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8197;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8197);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8197, 0, 0, 0, 0, 0, 100, 0, 1700, 2600, 9600, 12800, 11, 13748, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chronalis - In Combat - Cast \'13748\''),
(8197, 0, 1, 0, 12, 0, 100, 1, 40, 60, 0, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chronalis - Target Between 40-60% Health - Cast \'40504\' (No Repeat)'),
(8197, 0, 2, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 20717, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chronalis - Between 40-80% Health - Cast \'20717\' (No Repeat)'),
(8197, 0, 3, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 18144, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chronalis - Between 10-30% Health - Cast \'18144\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8198;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8198);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8198, 0, 0, 0, 0, 0, 100, 0, 2100, 3200, 9700, 11300, 11, 21073, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tick - In Combat - Cast \'21073\''),
(8198, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 20717, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tick - Between 40-80% Health - Cast \'20717\' (No Repeat)'),
(8198, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 18144, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tick - Between 10-30% Health - Cast \'18144\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5431;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5431);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5431, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 26064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Surf Glider - Between 20-80% Health - Cast \'26064\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5426;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5426);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5426, 0, 0, 0, 0, 0, 100, 0, 2700, 3200, 8900, 12100, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blisterpaw Hyena - In Combat - Cast \'3604\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5469;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5469);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5469, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 22500, 23000, 11, 9791, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dune Smasher - In Combat - Cast \'9791\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5430;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5430);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5430, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 16843, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Searing Roc - On Aggro - Cast \'16843\''),
(5430, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 8139, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Searing Roc - Between 20-80% Health - Cast \'8139\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5490;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5490);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5490, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 7948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnarled Thistleshrub - Between 30-60% Health - Cast \'7948\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

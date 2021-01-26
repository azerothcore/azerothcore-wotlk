-- DB update 2020_11_12_01 -> 2020_11_12_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_12_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_12_01 2020_11_12_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603643713252357500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603643713252357500');
/*
 * Zone: Badlands
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2753;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2753);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2753, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Barnabus - Between 20-80% Health - Cast \'3149\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7057;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7057);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7057, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 7164, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Digmaster Shovelphlange - On Aggro - Cast \'7164\' (No Repeat)'),
(7057, 0, 1, 0, 0, 0, 100, 0, 2700, 3100, 8600, 9400, 11, 8380, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Digmaster Shovelphlange - In Combat - Cast \'8380\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4872;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4872);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4872, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Obsidian Golem - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2735;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2735);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2735, 0, 0, 0, 2, 0, 100, 0, 1, 5, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lesser Rock Elemental - Between 1-5% Health - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2751;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2751);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2751, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 9576, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'War Golem - Between 30-60% Health - Cast \'9576\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2829;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2829);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2829, 0, 0, 0, 0, 0, 100, 0, 2700, 3200, 32700, 33200, 11, 3427, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Starving Buzzard - In Combat - Cast \'3427\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2727;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2727);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2727, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crag Coyote - Between 20-80% Health - Cast \'3149\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2723;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2723);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2723, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stone Golem - Between 20-80% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2850;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2850);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2850, 0, 0, 0, 0, 0, 100, 0, 2800, 3600, 17800, 18600, 11, 36590, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Broken Tooth - In Combat - Cast \'36590\''),
(2850, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 18501, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Broken Tooth - Between 5-30% Health - Cast \'18501\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2749;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2749);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2749, 0, 0, 0, 0, 0, 100, 0, 3400, 4200, 9600, 12800, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Siege Golem - In Combat - Cast \'3391\''),
(2749, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 9576, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Siege Golem - Between 5-30% Health - Cast \'9576\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2732;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2732);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2732, 0, 0, 0, 0, 0, 100, 0, 2300, 2700, 8700, 9700, 11, 51772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ridge Huntress - In Combat - Cast \'51772\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2754;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2754);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2754, 0, 0, 0, 0, 0, 100, 0, 3100, 4700, 9600, 12800, 11, 23392, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anathemus - In Combat - Cast \'23392\''),
(2754, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 21909, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Anathemus - Between 30-60% Health - Cast \'21909\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2944;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2944);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2944, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Boss Tho\'grun - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 92;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 92);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(92, 0, 0, 0, 2, 0, 100, 0, 1, 5, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rock Elemental - Between 1-5% Health - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2734;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2734);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2734, 0, 0, 0, 0, 0, 100, 0, 2300, 3700, 15200, 17700, 11, 36590, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ridge Stalker Patriarch - In Combat - Cast \'36590\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

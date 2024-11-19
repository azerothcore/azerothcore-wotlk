-- DB update 2020_06_12_01 -> 2020_06_12_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_12_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_12_01 2020_06_12_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588339406799887900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588339406799887900');

/*
 * Zone: Desolace
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 58, `maxdmg` = 79, `DamageModifier` = 1.03 WHERE `entry` = 4655;

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4655;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4655);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4655, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 13500, 15000, 11, 8379, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Wrangler - In Combat - Cast \'8379\''),
(4655, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 6533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Wrangler - Between 30-60% Health - Cast \'6533\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4654;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4654);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4654, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 6000, 6500, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Scout - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4657;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4657);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4657, 0, 0, 0, 0, 0, 100, 0, 1500, 1500, 4000, 4500, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Windchaser - In Combat - Cast \'9532\''),
(4657, 0, 1, 0, 2, 0, 100, 1, 15, 45, 0, 0, 11, 11986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Windchaser - Between 15-45% Health - Cast \'11986\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4656;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4656);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4656, 0, 0, 0, 0, 0, 100, 0, 1500, 1500, 7000, 8000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Mauler - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11686;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11686);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11686, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 6533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Raider - On Aggro - Cast \'6533\' (No Repeat)'),
(11686, 0, 1, 0, 0, 0, 100, 0, 2500, 3100, 7900, 8600, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Raider - In Combat - Cast \'6660\''),
(11686, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 17174, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Raider - Between 20-80% Health - Cast \'17174\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11687;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11687);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11687, 0, 0, 0, 0, 0, 100, 0, 2700, 3100, 8500, 9200, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Marauder - In Combat - Cast \'11976\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 13718;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 13718);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(13718, 0, 0, 0, 0, 0, 100, 0, 5400, 6200, 25900, 34600, 11, 15848, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Nameless Prophet - In Combat - Cast \'15848\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11685;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11685);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11685, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Priest - On Aggro - Cast \'11639\''),
(11685, 0, 1, 0, 0, 0, 100, 0, 3400, 4100, 9200, 10100, 11, 16568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Priest - In Combat - Cast \'16568\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

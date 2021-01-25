-- DB update 2020_08_13_00 -> 2020_08_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_13_00 2020_08_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1592668557058978500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1592668557058978500');
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

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4695;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4695);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4695, 0, 0, 0, 0, 0, 100, 0, 2100, 3800, 32100, 33800, 11, 3427, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Carrion Horror - In Combat - Cast \'3427\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4680;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4680);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4680, 0, 0, 0, 0, 0, 100, 1, 5000, 7000, 0, 0, 11, 6192, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doomwarder Captain - In Combat - Cast \'6192\' (No Repeat)'),
(4680, 0, 1, 0, 0, 0, 100, 0, 2100, 3400, 22100, 23400, 11, 3261, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doomwarder Captain - In Combat - Cast \'3261\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4677;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4677);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4677, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doomwarder - On Aggro - Cast \'7165\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4682;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4682);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4682, 0, 0, 0, 0, 0, 100, 0, 2200, 2400, 14200, 14400, 11, 7816, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nether Sister - In Combat - Cast \'7816\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5771;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5771);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5771, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12741, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jugkar Grim\'rod - On Aggro - Cast \'12741\''),
(5771, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 20787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jugkar Grim\'rod - Between 30-60% Health - Cast \'20787\' (No Repeat)'),
(5771, 0, 2, 0, 0, 0, 100, 0, 2100, 3100, 12100, 13100, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jugkar Grim\'rod - In Combat - Cast \'12471\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5760;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5760);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5760, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 10100, 10400, 11, 13737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Azrethoc - In Combat - Cast \'13737\''),
(5760, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 7961, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Azrethoc - Between 20-40% Health - Cast \'7961\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4676;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4676);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4676, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 2601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lesser Infernal - On Aggro - Cast \'2601\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4685;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4685);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4685, 0, 0, 0, 0, 0, 100, 0, 2100, 3200, 12100, 13200, 11, 22189, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ley Hunter - In Combat - Cast \'22189\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11559;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11559);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11559, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 18166, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Outcast Necromancer - On Aggro - Cast \'18166\''),
(11559, 0, 1, 0, 0, 0, 100, 0, 2200, 2400, 10200, 10400, 11, 20298, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Outcast Necromancer - In Combat - Cast \'20298\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11561;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11561);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11561, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Undead Ravager - On Just Summoned - Despawn In 30000 ms'),
(11561, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Undead Ravager - Between 20-80% Health - Cast \'11978\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5601;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5601);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5601, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Khan Jehn - On Aggro - Cast \'7164\''),
(5601, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Khan Jehn - Between 30-60% Health - Cast \'11972\' (No Repeat)'),
(5601, 0, 2, 0, 0, 0, 100, 0, 2500, 3000, 8500, 10000, 11, 8380, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Khan Jehn - In Combat - Cast \'8380\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6068;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6068);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6068, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warug\'s Bodyguard - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5600;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5600, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Khan Dez\'hepah - On Aggro - Cast \'7165\''),
(5600, 0, 1, 0, 0, 0, 100, 0, 2100, 3200, 8600, 9700, 11, 25710, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Khan Dez\'hepah - In Combat - Cast \'25710\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4637;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4637);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4637, 0, 0, 0, 0, 0, 100, 0, 1500, 3000, 10500, 13000, 11, 11824, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Destroyer - In Combat - Cast \'11824\''),
(4637, 0, 1, 0, 12, 0, 100, 1, 5, 30, 0, 0, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Destroyer - Target Between 5-30% Health - Cast \'7160\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4632;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4632);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4632, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 10100, 10400, 11, 25710, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Centaur - In Combat - Cast \'25710\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4636;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4636);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4636, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Battle Lord - On Aggro - Cast \'7165\''),
(4636, 0, 1, 0, 2, 0, 100, 1, 20, 90, 0, 0, 11, 8258, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Battle Lord - Between 20-90% Health - Cast \'8258\' (No Repeat)'),
(4636, 0, 2, 0, 0, 0, 100, 0, 2100, 3000, 9800, 10400, 11, 25710, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Battle Lord - In Combat - Cast \'25710\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4635;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4635);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4635, 0, 0, 0, 0, 0, 100, 0, 2100, 2300, 9600, 10200, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Windchaser - In Combat - Cast \'9532\''),
(4635, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 6728, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Windchaser - Between 30-60% Health - Cast \'6728\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4634;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4634);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4634, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Mauler - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4696;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4696);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4696, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 47500, 48000, 11, 5416, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scorpashi Snapper - In Combat - Cast \'5416\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4688;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4688);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4688, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 12500, 13000, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonepaw Hyena - In Combat - Cast \'3604\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4692;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4692);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4692, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dread Swoop - Between 30-60% Health - Cast \'5708\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11576;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11576);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11576, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8788, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Whirlwind Ripper - On Aggro - Cast \'8788\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4716;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4716);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4716, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 10277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Tidehunter - On Aggro - Cast \'10277\''),
(4716, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 865, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Tidehunter - Between 30-60% Health - Cast \'865\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4715;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4715);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4715, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8393, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Razortail - On Aggro - Cast \'8393\''),
(4715, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 7947, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Razortail - Between 40-80% Health - Cast \'7947\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4719;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4719);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4719, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Sea Witch - On Aggro - Cast \'12544\''),
(4719, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 8427, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Sea Witch - Between 40-80% Health - Cast \'8427\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4687;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4687);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4687, 0, 0, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deepstrider Searcher - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4714;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4714);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4714, 0, 0, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 7947, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Myrmidon - Between 40-80% Health - Cast \'7947\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4718;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4718);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4718, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11436, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Oracle - On Aggro - Cast \'11436\''),
(4718, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 5605, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Oracle - Between 20-80% Health - Cast \'5605\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12347;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12347);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12347, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enraged Reef Crawler - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4713;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4713);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4713, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Warrior - On Aggro - Cast \'7165\''),
(4713, 0, 1, 0, 2, 0, 100, 1, 60, 80, 0, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Warrior - Between 60-80% Health - Cast \'9080\' (No Repeat)'),
(4713, 0, 2, 0, 0, 0, 100, 0, 2500, 3000, 17500, 18000, 11, 11977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Warrior - In Combat - Cast \'11977\''),
(4713, 0, 3, 0, 2, 0, 100, 1, 20, 50, 0, 0, 11, 7947, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Warrior - Between 20-50% Health - Cast \'7947\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4711;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4711);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4711, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 7947, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Naga - Between 20-80% Health - Cast \'7947\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4712;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4712);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4712, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Sorceress - On Aggro - Cast \'12544\''),
(4712, 0, 1, 0, 0, 0, 100, 0, 2100, 3200, 9800, 11400, 11, 20819, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Sorceress - In Combat - Cast \'20819\''),
(4712, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 32011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Sorceress - Between 30-60% Health - Cast \'32011\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4690;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4690);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4690, 0, 0, 0, 0, 0, 100, 1, 2500, 5000, 0, 0, 11, 3150, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rabid Bonepaw - In Combat - Cast \'3150\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4693;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4693);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4693, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 6713, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dread Flyer - Between 20-80% Health - Cast \'6713\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11577;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11577);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11577, 0, 0, 0, 0, 0, 100, 0, 2100, 2500, 10100, 10500, 11, 11824, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Whirlwind Stormwalker - In Combat - Cast \'11824\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11562;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11562);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11562, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drysnap Crawler - On Aggro - Cast \'12544\''),
(11562, 0, 1, 0, 0, 0, 100, 0, 2100, 2400, 10100, 10400, 11, 12548, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drysnap Crawler - In Combat - Cast \'12548\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11563;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11563);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11563, 0, 0, 0, 0, 0, 100, 1, 2500, 5000, 0, 0, 11, 13443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drysnap Pincer - In Combat - Cast \'13443\' (No Repeat)'),
(11563, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 12000, 13000, 11, 13444, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drysnap Pincer - In Combat - Cast \'13444\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4699;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4699);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4699, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 40500, 41000, 11, 5416, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scorpashi Venomlash - In Combat - Cast \'5416\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4694;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4694);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4694, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 14100, 14400, 11, 3147, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dread Ripper - In Combat - Cast \'3147\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4727;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4727);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4727, 0, 0, 0, 0, 0, 100, 0, 2100, 2700, 10100, 10700, 11, 15611, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Elder Thunder Lizard - In Combat - Cast \'15611\''),
(4727, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 20535, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Elder Thunder Lizard - Between 30-60% Health - Cast \'20535\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11578;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11578);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11578, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 17100, 17400, 11, 13443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Whirlwind Shredder - In Combat - Cast \'13443\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4726;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4726);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4726, 0, 0, 0, 0, 0, 100, 0, 2100, 2400, 10100, 10400, 11, 15611, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Raging Thunder Lizard - In Combat - Cast \'15611\''),
(4726, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 20536, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Raging Thunder Lizard - Between 40-80% Health - Cast \'20536\' (No Repeat)'),
(4726, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Raging Thunder Lizard - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4661;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4661);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4661, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 33810, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gelkis Rumbler - Between 20-80% Health - Cast \'33810\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

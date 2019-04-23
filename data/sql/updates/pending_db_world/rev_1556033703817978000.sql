INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1556033703817978000');

-- Creating a new SmartAI script for [Creature] ENTRY 15650 (name: Crazed Dragonhawk)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15650;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15650);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15650, 0, 0, 0, 0, 0, 100, 0, 3100, 3100, 22800, 22800, 11, 29117, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crazed Dragonhawk - In Combat - Cast \'29117\'');


-- Creating a new SmartAI script for [Creature] ENTRY 15668 (name: Grimscale Murloc)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15668;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15668);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15668, 0, 0, 0, 0, 0, 100, 0, 7500, 7500, 45000, 45000, 11, 26661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimscale Murloc - In Combat - Cast \'26661\'');


-- Creating a new SmartAI script for [Creature] ENTRY 15636 (name: Eversong Green Keeper)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15636;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15636);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15636, 0, 0, 0, 0, 0, 100, 0, 6400, 6400, 47900, 47900, 11, 12160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eversong Green Keeper - In Combat - Cast \'12160\'');
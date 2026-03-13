-- DB update 2024_12_28_01 -> 2024_12_28_02
--
-- Adds if missing SAI to Deadwood Warrior, Gardener and Pathfinder
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` in (7153, 7154, 7155);

-- Deadwood Warrior
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 7153);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7153, 0, 0, 0, 0, 0, 100, 0, 4000, 11000, 12000, 15000, 0, 0, 11, 13583, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Warrior - In Combat - Cast \'Curse of the Deadwood\''),
(7153, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 5000, 10000, 0, 0, 11, 13584, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Warrior - In Combat - Cast \'Strike\'');

-- Deadwood Gardener
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7154) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7154, 0, 0, 0, 0, 0, 100, 0, 4000, 11000, 12000, 15000, 0, 0, 11, 13583, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Gardener - In Combat - Cast \'Curse of the Deadwood\''),
(7154, 0, 1, 0, 2, 0, 100, 0, 0, 70, 15000, 15000, 0, 0, 11, 12160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Gardener - Between 0-70% Health - Cast \'Rejuvenation\''),
(7154, 0, 3, 0, 2, 0, 100, 0, 0, 30, 10000, 10000, 0, 0, 11, 11986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Gardener - Between 0-30% Health - Cast \'Healing Wave\'');

-- Deadwood Pathfinder
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7155) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7155, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2200, 3800, 0, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Pathfinder - In Combat - Cast \'Shoot\''),
(7155, 0, 1, 0, 9, 0, 100, 0, 0, 0, 6000, 12000, 5, 30, 11, 6685, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Pathfinder - Within 5-30 Range - Cast \'Piercing Shot\''),
(7155, 0, 2, 0, 0, 0, 100, 0, 5000, 9000, 125000, 130000, 0, 0, 11, 13583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Pathfinder - In Combat - Cast \'Curse of the Deadwood\'');

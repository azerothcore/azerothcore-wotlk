-- DB update 2023_03_15_02 -> 2023_03_15_03
-- Ridgespine Horror
UPDATE `creature_template_addon` SET `auras` = '7939 22766' WHERE `entry` = 20998;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20998;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 20998;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20998, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 8000, 12000, 0, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ridgespine Horror - In Combat - Cast \'Web\''),
(20998, 0, 1, 0, 0, 0, 100, 0, 0, 0, 5000, 12000, 0, 11, 7951, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ridgespine Horror - In Combat - Cast \'Toxic Spit\'');

-- Ridgespine Stalker
UPDATE `creature_template_addon` SET `auras` = '7939 22766' WHERE `entry` = 20714;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 20714;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20714, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 8000, 12000, 0, 11, 744, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ridgespine Stalker - In Combat - Cast \'Poison\'');

-- DB update 2023_09_18_03 -> 2023_09_18_04
--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 17265;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17265) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17265, 0, 0, 0, 60, 0, 100, 0, 2400, 8000, 2400, 8000, 0, 11, 30184, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fiendish Portal - On Update - Cast \'Summon Fiendish Imp\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 17267;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17267) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17267, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 2000, 2200, 0, 11, 30050, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fiendish Imp - In Combat - Cast \'Firebolt\'');

UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1 WHERE `entry` = 17229;

--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_chapter2_persuasive_strike';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(52781, 'spell_chapter2_persuasive_strike');

UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` IN (28610, 28936, 28939, 28940);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28936) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28936, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52221, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander - In Combat - Cast \'Heroic Strike\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28940) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28940, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 52221, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - In Combat - Cast \'Heroic Strike\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28610) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28610, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 32915, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Marksman - In Combat - Cast \'Raptor Strike\'');

DELETE FROM `spell_script_names` WHERE `spell_id` = 28865;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(28865,'spell_gen_consumption');

DELETE FROM `creature_template_spell` WHERE `CreatureID` = 16697;

UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` = 16697;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16697);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16697, 0, 0, 0, 60, 0, 100, 0, 0, 0, 2500, 2500, 0, 0, 11, 28865, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Void Zone - On Update - Cast \'Consumption\''),
(16697, 0, 1, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Void Zone - On Initialize - Set Reactstate Passive');

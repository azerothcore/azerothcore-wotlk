UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25952;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25952) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25952, 0, 0, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 11, 46314, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Slippery Floor Bunny - On Just Created - Cast \'Ahune - Slippery Floor Ambient\'');

DELETE FROM `spell_script_names` WHERE `spell_id` = 46314;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(46314, 'spell_ahune_slippery_ambient');

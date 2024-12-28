-- DB update 2023_11_20_07 -> 2023_11_20_08
--
UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` = 10992;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10992);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10992, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Panther - On Reset - Set Reactstate Passive'),
(10992, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Panther - On Reset - Set Flags Not Attackable');

UPDATE `gameobject_template` SET  `ScriptName` = '' WHERE `entry` = 176195;

DELETE FROM `spell_script_names` WHERE `spell_id` = 17176;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(17176, 'spell_panther_cage_key');


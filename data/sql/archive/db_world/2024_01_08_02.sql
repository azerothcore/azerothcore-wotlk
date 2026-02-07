-- DB update 2024_01_08_01 -> 2024_01_08_02
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18544);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18544, 0, 0, 0, 1, 0, 100, 257, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3832.74, 1448.12, -138.4, 0, 'Veraku - Out of Combat - Move To Position'),
(18544, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Veraku - On Just Summoned - Start Attacking');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_challenge_veraku';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(34895, 'spell_challenge_veraku');

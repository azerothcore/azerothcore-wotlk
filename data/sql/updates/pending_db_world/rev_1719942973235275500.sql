-- Glumdor
DELETE FROM `spell_script_names` WHERE `spell_id`=36208 AND `ScriptName`='spell_gen_steal_weapon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (36208, 'spell_gen_steal_weapon');

DELETE FROM `creature_text` WHERE (`CreatureID` = 20730);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20730, 0, 0, 'Stupid, squishy $r. That weapon mine now! Give!', 12, 0, 100, 0, 0, 0, 19510, 0, 'Glumdor - Steal Weapon'),
(20730, 1, 0, 'I\'ll crush you!', 12, 0, 100, 0, 0, 0, 1925, 0, 'Glumdor - Aggro'),
(20730, 1, 1, 'Me smash! You die!', 12, 0, 100, 0, 0, 0, 1926, 0, 'Glumdor - Aggro');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20730);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20730, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glumdor - On Aggro - Say Line 1'),
(20730, 0, 1, 0, 0, 0, 100, 0, 2500, 4000, 11500, 14000, 0, 0, 11, 32009, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Glumdor - In Combat - Cast \'Cutdown\''),
(20730, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 0, 11, 36208, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Glumdor - Between 20-80% Health - Cast \'Steal Weapon\' (No Repeat)'),
(20730, 0, 3, 0, 2, 0, 100, 1, 10, 30, 0, 0, 0, 0, 11, 8599, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glumdor - Between 10-30% Health - Cast \'Enrage\' (No Repeat)'),
(20730, 0, 4, 0, 9, 0, 100, 1, 0, 5000, 0, 0, 0, 5, 11, 13730, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Glumdor - Within 0-5 Range - Cast \'Demoralizing Shout\' (No Repeat)');

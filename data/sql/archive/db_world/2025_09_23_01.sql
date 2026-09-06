-- DB update 2025_09_23_00 -> 2025_09_23_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27996);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27996, 0, 0, 0, 1, 0, 100, 512, 9000, 9000, 30000, 30000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Vanquisher - Out of Combat - Say Line 0'),
(27996, 0, 1, 0, 2, 0, 100, 513, 0, 33, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Vanquisher - Between 0-33% Health - Say Line 1 (No Repeat)'),
(27996, 0, 3, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Vanquisher - On Just Summoned - Set Reactstate Passive'),
(27996, 0, 4, 5, 28, 0, 100, 512, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 202, 15, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Vanquisher - On Passenger Removed - Move To Random Point'),
(27996, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Vanquisher - On Passenger Removed - Say Line 2'),
(27996, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Vanquisher - On Passenger Removed - Despawn In 3000 ms'),
(27996, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 44795, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Vanquisher - On Passenger Removed - Invoker Cast \'Parachute\'');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2800500 AND `source_type` = 9;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28005) AND (`source_type` = 0) AND (`id` IN (1));

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_dragonblight_devour_ghoul', 'spell_dragonblight_devour_ghoul_periodic');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(50430, 'spell_dragonblight_devour_ghoul'),
(50432, 'spell_dragonblight_devour_ghoul_periodic');

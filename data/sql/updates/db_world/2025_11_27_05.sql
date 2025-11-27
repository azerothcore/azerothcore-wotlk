-- DB update 2025_11_27_04 -> 2025_11_27_05

--  Updated SAI & comments
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27587;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27587);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27587, 0, 0, 0, 38, 0, 100, 512, 0, 1, 0, 0, 0, 0, 11, 49122, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Steam Tank - On Data Set 0 1 - Cast \'Plague Wagon Credit\''),
(27587, 0, 1, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Steam Tank - On Reset - Set Reactstate Passive'),
(27587, 0, 2, 0, 1, 0, 100, 512, 30000, 30000, 50000, 50000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 27588, 10, 0, 0, 0, 0, 0, 0, 'Alliance Steam Tank - Out of Combat - Say Line 1'),
(27587, 0, 3, 0, 8, 0, 100, 512, 49081, 0, 0, 0, 0, 0, 80, 2758700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Steam Tank - On Spellhit \'Drop Off Soldier\' - Run Script'),
(27587, 0, 4, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Steam Tank - On Reset - Set Run On'),
(27587, 0, 5, 6, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 6000, 0, 0, 0, 0, 0, 29, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Steam Tank - On Passenger Removed - Despawn In 6000 ms'),
(27587, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 6000, 0, 0, 0, 0, 0, 29, 2, 0, 0, 0, 0, 0, 0, 0, 'Alliance Steam Tank - On Passenger Removed - Despawn In 6000 ms'),
(27587, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 6000, 0, 0, 0, 0, 0, 29, 3, 0, 0, 0, 0, 0, 0, 0, 'Alliance Steam Tank - On Passenger Removed - Despawn In 6000 ms'),
(27587, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Steam Tank - On Passenger Removed - Despawn In 6000 ms');

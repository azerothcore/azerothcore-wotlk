-- DB update 2025_10_04_04 -> 2025_10_04_05

-- Update SmartAI (Horde Siege Tank and Barrels).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (25334, 27064));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (25334, 27064));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27064, 0, 0, 1, 103, 0, 100, 512, 0, 25334, 1, 2, 0, 0, 11, 47916, 2, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Abandoned Fuel Tank - On 1 or More Units in Range - Cast \'Fuel\''),
(27064, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Abandoned Fuel Tank - On 1 or More Units in Range - Despawn In 4000 ms'),
(27064, 0, 2, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Abandoned Fuel Tank - On Respawn - Stop Attacking'),
(25334, 0, 0, 0, 8, 0, 100, 512, 47916, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Siege Tank - On Spellhit \'Fuel\' - Say Line 0'),
(25334, 0, 1, 0, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Siege Tank - On Passenger Removed - Despawn In 1000 ms');

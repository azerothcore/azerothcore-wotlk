-- DB update 2025_07_21_00 -> 2025_07_21_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 27593;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27593);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27593, 0, 0, 0, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 49107, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocket Propelled Warhead - On Passenger Boarded - Cast \'Vehicle: Warhead Fuse\''),
(27593, 0, 1, 3, 8, 0, 100, 512, 49372, 0, 0, 0, 0, 0, 11, 49510, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocket Propelled Warhead - On Spellhit \'Horde Boat to Torpedo\' - Cast \'Alliance Kill Credit Torpedo\''),
(27593, 0, 2, 3, 8, 0, 100, 512, 49257, 0, 0, 0, 0, 0, 11, 49340, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocket Propelled Warhead - On Spellhit \'Alliance Boat to Torpedo\' - Cast \'Horde Kill Credit Torpedo\''),
(27593, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 49250, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocket Propelled Warhead - On Event Link - Cast \'Detonate\'');

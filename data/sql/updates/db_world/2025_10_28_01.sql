-- DB update 2025_10_28_00 -> 2025_10_28_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27972;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27972);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27972, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 9000, 15000, 0, 0, 11, 52383, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Lightning Construct - In Combat - Cast \'Chain Lightning\' (No Repeat) (Dungeon/Normal)'),
(27972, 0, 1, 0, 0, 0, 100, 4, 3000, 6000, 9000, 15000, 0, 0, 11, 61528, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Lightning Construct - In Combat - Cast \'Chain Lightning\' (No Repeat) (Dungeon/Heroic)'),
(27972, 0, 2, 0, 0, 0, 100, 515, 7000, 28000, 14000, 27000, 0, 0, 11, 52341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lightning Construct - On Just Died - Cast \'Electrical Overload\' (Dungeon/Normal)'),
(27972, 0, 3, 0, 0, 0, 100, 517, 7000, 28000, 14000, 27000, 0, 0, 11, 59038, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lightning Construct - On Just Died - Cast \'Electrical Overload\' (Dungeon/Heroic)');

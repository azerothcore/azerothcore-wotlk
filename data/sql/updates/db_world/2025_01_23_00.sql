-- DB update 2025_01_22_02 -> 2025_01_23_00

-- Phoenix
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24674;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24674);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24674, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44196, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Initialize - Cast \'Rebirth\''),
(24674, 0, 1, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 0, 0, 11, 44197, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Update - Cast \'Burn\' (No Repeat)'),
(24674, 0, 2, 0, 24, 0, 100, 0, 44226, 1, 5000, 5000, 0, 0, 11, 44202, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Target Buffed With \'Gravity Lapse\' - Cast \'Fireball\''),
(24674, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Reset - Start Attacking'),
(24674, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24675, 3, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Just Died - Summon Creature \'Phoenix Egg\''),
(24674, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Just Died - Despawn In 1000 ms');

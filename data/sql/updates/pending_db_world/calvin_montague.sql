--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 6784;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 6784 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6784, 0, 0, 1, 19, 0, 100, 512, 590, 0, 0, 0, 0, 0, 2, 168, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On Quest accepted - Set faction enemy'),
(6784, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On Quest accepted - Remove unit flag \'UNIT_FLAG_IMMUNE_TO_PC\''),
(6784, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 123, 1, 0, 0, 0, 0, 0, 17, 0, 15, 5, 0, 0, 0, 0, 0, 'Calvin Montague - On Quest accepted - Add threat to nearby players'),
(6784, 0, 3, 4, 2, 0, 100, 513, 0, 15, 0, 0, 0, 0, 2, 68, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On 0-15% health - Restore faction'),
(6784, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On 0-15% health - Add unit flag \'UNIT_FLAG_IMMUNE_TO_PC\''),
(6784, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On 0-15% health - Create timed event 1'),
(6784, 0, 6, 7, 59, 0, 100, 512, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On timed event 1 - Say line 0'),
(6784, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 2, 7500, 7500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On timed event 1 - Create timed event 2'),
(6784, 0, 8, 9, 59, 0, 100, 512, 2, 0, 0, 0, 0, 0, 15, 590, 0, 0, 0, 0, 0, 17, 0, 15, 5, 0, 0, 0, 0, 0, 'Calvin Montague - On timed event 2 - Complete quest 590'),
(6784, 0, 9, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 2639, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On timed event 2 - Cast spell \'Drink\''),
(6784, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 3, 7500, 7500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On timed event 2 - Create timed event 3'),
(6784, 0, 11, 0, 59, 0, 100, 512, 3, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On timed event 3 - Evade');

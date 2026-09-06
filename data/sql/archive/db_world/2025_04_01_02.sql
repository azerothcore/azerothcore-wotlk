-- DB update 2025_04_01_01 -> 2025_04_01_02

-- Remove flags and edit walk and run speed (sniffed)
UPDATE `creature_template` SET `unit_flags` = `unit_flags`& ~131072, `unit_flags2` = `unit_flags2`& ~2048, `flags_extra` = `flags_extra`& ~2, `speed_walk` = 1.2, `speed_run` = 0.4 WHERE (`entry` = 25744);

-- Update invicibility to 1% and attack.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25744;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25744);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25744, 0, 0, 1, 37, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Initialize - Set Reactstate Passive'),
(25744, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 45934, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Initialize - Cast \'Dark Fiend\''),
(25744, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 45936, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Initialize - Cast \'Dark Fiend\''),
(25744, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Initialize - Set Invincibility Hp 1%'),
(25744, 0, 4, 0, 60, 0, 100, 1, 1000, 2000, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 200, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Update - Start Attacking (No Repeat)'),
(25744, 0, 5, 6, 9, 0, 100, 1, 0, 0, 0, 0, 0, 4, 11, 45944, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - Within 0-4 Range - Cast \'Dark Fiend\' (No Repeat)'),
(25744, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - Within 0-0 Range - Despawn Instant (No Repeat)'),
(25744, 0, 7, 0, 23, 0, 100, 512, 45934, 0, 500, 500, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Fiend - On Aura \'Dark Fiend\' - Despawn Instant');

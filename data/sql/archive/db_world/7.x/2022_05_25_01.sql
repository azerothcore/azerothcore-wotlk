-- DB update 2022_05_25_00 -> 2022_05_25_01
-- Commander Felstrom, set unlootable if resurrection goes through and despawn body after
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 771;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 771;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(771, 0, 0, 0, 2, 0, 100, 1, 0, 10, 0, 0, 0, 11, 3488, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Felstrom - Between 0-10% Health - Cast \'Felstrom Resurrection\' (No Repeat)'),
(771, 0, 1, 2, 8, 0, 100, 0, 3488, 0, 0, 0, 0, 94, 128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Felstrom - On Spellhit \'Felstrom Resurrection\' - Set Dynamic Flags Tapped By Threatlist'),
(771, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Felstrom - On Spellhit \'Felstrom Resurrection\' - Despawn In 2000 ms');

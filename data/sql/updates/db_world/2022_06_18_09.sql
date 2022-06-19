-- DB update 2022_06_18_08 -> 2022_06_18_09
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11350;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11350);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11350, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Axe Thrower - On Aggro - Say Line 1'),
(11350, 0, 1, 0, 9, 0, 100, 1, 5, 30, 1500, 2000, 0, 11, 22887, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Axe Thrower - Within 5-30 Range - Cast \'Throw\' (No Repeat)'),
(11350, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Axe Thrower - Between 0-30% Health - Cast \'Frenzy\' (No Repeat)'),
(11350, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Axe Thrower - Between 0-30% Health - Say Line 0 (No Repeat)'),
(11350, 0, 4, 0, 0, 0, 100, 0, 15000, 15000, 25000, 28000, 0, 11, 24018, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Axe Thrower - In Combat - Cast \'Axe Flurry\'');

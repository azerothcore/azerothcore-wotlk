-- DB update 2022_06_16_00 -> 2022_06_16_01
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16332;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16332);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16332, 0, 0, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Out of Combat - Disable Combat Movement'),
(16332, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Out of Combat - Stop Attacking'),
(16332, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - On Aggro - Cast \'Shoot\''),
(16332, 0, 3, 4, 9, 0, 100, 0, 5, 30, 2300, 3900, 0, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Within 5-30 Range - Cast \'Shoot\''),
(16332, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Within 5-30 Range - Set Sheath Ranged'),
(16332, 0, 5, 6, 9, 0, 100, 0, 25, 80, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Within 25-80 Range - Enable Combat Movement'),
(16332, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Within 25-80 Range - Start Attacking'),
(16332, 0, 7, 8, 9, 0, 100, 0, 0, 5, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Within 0-5 Range - Enable Combat Movement'),
(16332, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Within 0-5 Range - Set Sheath Melee'),
(16332, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Within 0-5 Range - Start Attacking'),
(16332, 0, 10, 0, 9, 0, 100, 0, 5, 15, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Within 5-15 Range - Disable Combat Movement'),
(16332, 0, 11, 0, 9, 0, 100, 0, 0, 5, 5000, 9000, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Within 0-5 Range - Cast \'Strike\''),
(16332, 0, 12, 13, 2, 0, 100, 0, 0, 15, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Between 0-15% Health - Enable Combat Movement'),
(16332, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - Between 0-15% Health - Flee For Assist'),
(16332, 0, 14, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Huntress - On Evade - Set Sheath Melee');

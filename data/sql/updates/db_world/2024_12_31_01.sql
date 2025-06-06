-- DB update 2024_12_31_00 -> 2024_12_31_01

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28557;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28557);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28557, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On Reset - Set Reactstate Passive'),
(28557, 0, 1, 2, 101, 0, 100, 0, 1, 3, 3000, 0, 0, 0, 11, 51604, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On 1 or More Players in Range - Cast \'Serverside - Stun Self\''),
(28557, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 14561, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On 1 or More Players in Range - Play Sound 14561'),
(28557, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On 1 or More Players in Range - Set Emote State 431'),
(28557, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 3, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On 1 or More Players in Range - Set Orientation Closest Player'),
(28557, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 3, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On 1 or More Players in Range - Say Line 0'),
(28557, 0, 6, 0, 102, 0, 100, 0, 1, 3, 30000, 30000, 30000, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On Less Than 1 Players in Range - Evade');

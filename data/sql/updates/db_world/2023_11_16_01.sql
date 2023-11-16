-- DB update 2023_11_16_00 -> 2023_11_16_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 6090;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 6090);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6090, 0, 0, 1, 19, 0, 100, 0, 1640, 0, 0, 0, 0, 0, 2, 168, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby - On Quest \'Beat Bartleby\' Taken - Set Faction 168'),
(6090, 0, 1, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby - On Quest \'Beat Bartleby\' Taken - Start Attacking'),
(6090, 0, 2, 3, 2, 0, 100, 0, 0, 15, 0, 0, 0, 0, 15, 1640, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby - Between 0-15% Health - Quest Credit \'Beat Bartleby\''),
(6090, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby - Between 0-15% Health - Evade'),
(6090, 0, 4, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby - On Quest \'Beat Bartleby\' Taken - Set Invincibility Hp 15%'),
(6090, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 84, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby - On Reset - Set Faction 84'),
(6090, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby - On Quest \'Beat Bartleby\' Taken - Store Targetlist');


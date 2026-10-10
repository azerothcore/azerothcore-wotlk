--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 9598 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9598, 0, 0, 1, 19, 0, 100, 512, 4261, 0, 0, 0, 0, 0, 53, 1, 9598, 0, 0, 1000, 2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP'),
(9598, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk'),
(9598, 0, 2, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Arei - On Aggro - Start Attacking'),
(9598, 0, 3, 0, 40, 0, 100, 0, 13, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 16777215, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk'),
(9598, 0, 4, 5, 40, 0, 100, 0, 34, 0, 0, 0, 0, 0, 12, 7138, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 0, 6534.9, -1203.5, 436.73, 3.14, 'On WP Reach - Summon Creature'),
(9598, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 7138, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 0, 6527.64, -1196.54, 435.9, 3.9, 'On WP Reach - Summon Creature'),
(9598, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 7138, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 0, 6532.7, -1216.04, 434.4, 2.4, 'On WP Reach - Summon Creature'),
(9598, 0, 7, 8, 40, 0, 100, 512, 38, 0, 0, 0, 0, 0, 54, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Stop WP'),
(9598, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase'),
(9598, 0, 9, 0, 60, 1, 100, 1, 1000, 1000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 16777215, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk'),
(9598, 0, 10, 0, 60, 1, 100, 1, 7000, 7000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 16777215, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk'),
(9598, 0, 11, 0, 60, 1, 100, 1, 11000, 11000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 12, 16777215, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk'),
(9598, 0, 12, 0, 60, 1, 100, 1, 18000, 18000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 12, 16777215, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk'),
(9598, 0, 13, 0, 60, 1, 100, 513, 19000, 19000, 0, 0, 0, 0, 26, 4261, 0, 0, 0, 0, 0, 12, 16777215, 0, 0, 0, 0, 0, 0, 0, 'Arei - On Update - Quest Credit \'Ancient Spirit\'');

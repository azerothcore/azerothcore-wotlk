
-- Edit SAI (Talbot)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25301;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25301) AND (`source_type` = 0) AND (`id` IN (3, 4, 5, 6, 7, 8, 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25301, 0, 3, 4, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Just Summoned - Remove Npc Flags Questgiver'),
(25301, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 253011, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Just Summoned - Start Path 253011'),
(25301, 0, 5, 0, 109, 0, 100, 0, 0, 253011, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Path Finished - Send Action to Thassarian'),
(25301, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 25250, 100, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Just Died - Send Event to General Arlos'),
(25301, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 25251, 100, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Just Died - Send Event to Leryssa'),
(25301, 0, 8, 0, 109, 0, 100, 0, 0, 253011, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Path Finished - Set Flag Standstate Kneel'),
(25301, 0, 9, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Respawn - Deload Equipment');

-- Edit Action Lists (Thassarian)
UPDATE `smart_scripts` SET `action_param3` = 1 WHERE (`entryorguid` = 2617004) AND (`source_type` = 9) AND (`id` IN (2));
UPDATE `smart_scripts` SET `action_param3` = 1 WHERE (`entryorguid` = 2617001) AND (`source_type` = 9) AND (`id` IN (5));

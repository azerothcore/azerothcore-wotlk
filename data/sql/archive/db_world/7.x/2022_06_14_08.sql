-- DB update 2022_06_14_07 -> 2022_06_14_08
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4966;
DELETE FROM `smart_scripts` WHERE ((`entryorguid` = 496603) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3))) OR ((`entryorguid` = 496600) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5, 6))) OR ((`entryorguid` = 5184) AND (`source_type` = 0)) OR (`source_type` = 0 AND `entryorguid` = 4966 AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4966, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - On Respawn - Set Emote State 0'),
(4966, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - On Respawn - Add Npc Flags Questgiver'),
(4966, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - On Respawn - Reset Invincibility Hp'),
(4966, 0, 3, 0, 19, 0, 100, 512, 1324, 0, 0, 0, 0, 80, 496600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - On Quest \'The Missing Diplomat\' Taken - Run Script'),
(4966, 0, 4, 0, 7, 1, 100, 513, 0, 0, 0, 0, 0, 80, 496603, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - On Evade - Run Script (Phase 1) (No Repeat)'),
(4966, 0, 6, 0, 2, 1, 100, 512, 0, 20, 300, 500, 0, 80, 496601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Between 0-20% Health - Run Script (Phase 1)'),
(4966, 0, 7, 0, 40, 2, 100, 512, 1, 496600, 0, 0, 0, 80, 496602, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - On Waypoint 1 Reached - Run Script (Phase 2)'),
(496600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Remove Npc Flags Questgiver'),
(496600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Set Invincibility Hp 1'),
(496600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 168, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Set Faction 168'),
(496600, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 5184, 50, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Set Data 1 1'),
(496600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Store Targetlist'),
(496600, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Start Attacking'),
(496600, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Set Event Phase 1'),
(5184, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Theramore Sentry - On Aggro - Cast \'Battle Stance\''),
(5184, 0, 1, 0, 38, 0, 100, 513, 3, 3, 1, 2, 0, 41, 60000, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Theramore Sentry - On Data Set 3 3 - Despawn In 60000 ms (No Repeat)'),
(496603, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 41, 1, 300, 0, 0, 0, 0, 19, 5184, 50, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Despawn In 1000 ms'),
(496603, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 6, 1324, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Fail Quest \'The Missing Diplomat\''),
(496603, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 41, 1, 300, 0, 0, 0, 0, 19, 5184, 50, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Despawn Instant'),
(496603, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 1, 300, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Private Hendel - Actionlist - Despawn Instant');

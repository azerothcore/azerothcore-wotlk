-- DB update 2026_08_15_03 -> 2026_08_15_04
-- These have ancient SAI that became broken over the years. 15 rows can now be represented in only 3
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27749) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27749, 0, 0, 0, 9, 0, 100, 0, 0, 0, 2300, 3900, 5, 30, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Conscript - Within 5-30 Range - Cast \'Shoot\''),
(27749, 0, 1, 0, 9, 0, 100, 0, 7000, 9000, 7000, 9000, 0, 5, 11, 29426, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Conscript - Within 0-5 Range - Cast \'Heroic Strike\''),
(27749, 0, 2, 0, 1, 0, 100, 0, 0, 5000, 0, 10000, 0, 0, 11, 49329, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Conscript - Out of Combat - Cast \'Summon Frigid Ghoul Attacker\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27564) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27564, 0, 0, 0, 9, 0, 100, 0, 0, 0, 2300, 3900, 5, 30, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Conscript - Within 5-30 Range - Cast \'Shoot\''),
(27564, 0, 1, 0, 9, 0, 100, 0, 7000, 9000, 7000, 9000, 0, 5, 11, 29426, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Conscript - Within 0-5 Range - Cast \'Heroic Strike\''),
(27564, 0, 2, 0, 1, 0, 100, 0, 0, 5000, 0, 10000, 0, 0, 11, 49329, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Conscript - Out of Combat - Cast \'Summon Frigid Ghoul Attacker\'');

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2097152 WHERE (`entry` IN (27685, 27686, 27531));

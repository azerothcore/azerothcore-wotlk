-- DB update 2025_07_09_00 -> 2025_07_10_00

-- Set SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (28610, 28936, 28940, 28939, 28964));

-- Scarlet Commander, Crusader and Marksman.
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (28610, 28936, 28940)) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28610, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Marksman - On Respawn - Remove Flags Not Attackable'),
(28940, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Respawn - Remove Flags Not Attackable'),
(28936, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander - On Respawn - Remove Flags Not Attackable');

-- Scarlet Preacher
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28939) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28939, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Preacher - On Respawn - Remove Flags Not Attackable');

-- Scarlet Lord Jesseriah McCree.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28964) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28964, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 8000, 12000, 0, 0, 11, 52835, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Lord Jesseriah McCree - In Combat - Cast \'Cleave\''),
(28964, 0, 1, 0, 0, 0, 100, 0, 12000, 18000, 30000, 35000, 0, 0, 11, 52836, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Lord Jesseriah McCree - In Combat - Cast \'Holy Wrath\''),
(28964, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Lord Jesseriah McCree - On Respawn - Remove Flags Not Attackable');

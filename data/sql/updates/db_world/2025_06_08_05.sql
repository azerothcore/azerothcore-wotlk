-- DB update 2025_06_08_04 -> 2025_06_08_05
--
-- Alliance, Horde Captains and Shattered Hand Executioner NPCs
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17290;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17296;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17301;

-- Causes quest to fail on Alliance Captain death
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17290) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17290, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 9524, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Fail quest on captain death.');

-- Causes quest to fail on Horde Captain death
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17296) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17296, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 9525, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Fail quest on captain death.');

-- Grants kill token for quest completion on Shattered Hand Executioner death
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17301) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17301, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 17290, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Executioner - On Death - Quest Credit for Alliance'),
(17301, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 17296, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Executioner - On Death - Quest Credit for Horde');

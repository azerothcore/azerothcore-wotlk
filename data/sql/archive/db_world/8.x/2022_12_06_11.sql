-- DB update 2022_12_06_10 -> 2022_12_06_11
-- Adds stealth detect aura
DELETE FROM `creature_template_addon` WHERE (`entry` = 17624);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17624, 0, 0, 0, 0, 0, 0, '18950');
DELETE FROM `creature_addon` WHERE (`guid` IN (138187));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(138187, 1381870, 0, 0, 0, 0, 0, '18950');
-- Remove Stealth detect smartai and reorder
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17624;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17624) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17624, 0, 1, 0, 0, 0, 100, 0, 300, 1200, 15800, 15800, 0, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Warden - In Combat - Cast Battle Shout');

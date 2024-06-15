-- DB update 2022_09_02_02 -> 2022_09_02_03
-- Voodoo Spirit - Add aura 24051
DELETE FROM `creature_template_addon` WHERE (`entry` = 15009);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(15009, 0, 0, 0, 0, 0, 0, '24051');

-- Add SAI to kill Voodoo Spirit after 10s (sniffed)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15009;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15009) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15009, 0, 0, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voodoo Spirit - In Combat - Kill Self');

-- Update Hakkari Witch Doctor to summon Voodoo Spirit on Death
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11831) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11831, 0, 4, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 11, 24052, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - On Just Died - Cast \'Summon Voodoo Spirit\'');

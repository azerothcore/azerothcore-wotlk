-- DB update 2025_01_05_03 -> 2025_01_05_04

-- Remove unit flag "stunned" from Citizen of Havenshire
UPDATE `creature_template` SET `unit_flags`=`unit_flags`& ~262144 WHERE (`entry` = 28576);

-- Update SmartAI for Citizens of Havenshire (rows 12-13 are Guid Reserved)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28576;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28576) AND (`source_type` = 0) AND (`id` IN (14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28576, 0, 14, 0, 1, 0, 30, 0, 5000, 20000, 5000, 20000, 0, 0, 11, 52149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Out of Combat - Cast \'Rain of Darkness\''),
(28576, 0, 15, 0, 8, 0, 100, 0, 52149, 0, 0, 0, 0, 0, 142, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - On Spellhit \'Rain of Darkness\' - Set HP to 10%');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28577;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28577) AND (`source_type` = 0) AND (`id` IN (14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28577, 0, 14, 0, 1, 0, 30, 0, 5000, 20000, 5000, 20000, 0, 0, 11, 52149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - Out of Combat - Cast \'Rain of Darkness\''),
(28577, 0, 15, 0, 8, 0, 100, 0, 52149, 0, 0, 0, 0, 0, 142, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of Havenshire - On Spellhit \'Rain of Darkness\' - Set HP to 10%');

-- Remove aura from Scourge Sky Darkeners
UPDATE `creature_template_addon` SET `visibilityDistanceType` = 0, `auras` = '' WHERE (`entry` = 28642);

-- Add SmartAI for Scourge Sky Darkeners
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28642;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28642);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28642, 0, 0, 0, 1, 0, 100, 0, 5000, 20000, 5000, 20000, 0, 0, 11, 52147, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Sky Darkener - Out of Combat - Cast \'Sky Darkener Assault\'');

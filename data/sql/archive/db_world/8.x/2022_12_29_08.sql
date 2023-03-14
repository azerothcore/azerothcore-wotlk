-- DB update 2022_12_29_07 -> 2022_12_29_08
-- 
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17136;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17136) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17136, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 0, 11, 30798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Warrior - On Respawn - Cast \'Dual Wield\' (No Repeat)'),
(17136, 0, 1, 0, 9, 0, 100, 0, 8, 25, 18000, 24000, 0, 11, 31994, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Warrior - Within 8-25 Range - Cast \'Shoulder Charge\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17137;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17137) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17137, 0, 0, 0, 16, 0, 100, 0, 6742, 30, 15000, 45000, 0, 11, 6742, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Mage - On Friendly Unit Missing Buff \'Bloodlust\' - Cast \'Bloodlust\''),
(17137, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 9000, 12000, 0, 11, 20795, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Mage - In Combat - Cast \'Fire Blast\''),
(17137, 0, 2, 0, 0, 0, 100, 0, 5000, 9000, 3800, 5200, 0, 11, 9672, 0, 256, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Mage - In Combat - Cast \'Frostbolt\'');

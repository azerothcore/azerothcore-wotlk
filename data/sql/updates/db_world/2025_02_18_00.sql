-- DB update 2025_02_16_03 -> 2025_02_18_00

-- Remove Wrong Spawns
DELETE FROM `creature` WHERE `id1` = 28745;

-- Blight Cauldron Bunny 00 SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28739;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28739);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28739, 0, 0, 1, 8, 0, 100, 0, 52227, 0, 0, 0, 0, 0, 11, 52228, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Cauldron Bunny 00 - On Spellhit \'Dilute Blight Cauldron\' - Cast \'Kill Credit\''),
(28739, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52231, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Cauldron Bunny 00 - On Spellhit \'Dilute Blight Cauldron\' - Cast \'Cauldron Diluted Effect\''),
(28739, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 28745, 4, 30000, 0, 0, 0, 202, 20, 3, 1, 0, 0, 0, 0, 0, 'Blight Cauldron Bunny 00 - On Spellhit \'Dilute Blight Cauldron\' - Summon Creature \'Alarmed Blightguard\''),
(28739, 0, 3, 0, 1, 0, 100, 512, 30000, 30000, 30000, 30000, 0, 0, 28, 52231, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Cauldron Bunny 00 - Out of Combat - Remove Aura \'Cauldron Diluted Effect\'');

-- Set Random Movement for Alarmed Blightguard
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28745;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28745);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28745, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alarmed Blightguard - On Reset - Start Random Movement');

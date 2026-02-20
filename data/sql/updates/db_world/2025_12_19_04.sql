-- DB update 2025_12_19_03 -> 2025_12_19_04
--
-- Bane SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25655;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25655);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25655, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 15000, 20000, 0, 0, 11, 50332, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bane - In Combat - Cast \'Fool\'s Bane\'');

-- Rockfang SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25774;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25774);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25774, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46221, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rockfang - On Just Died - Cast \'Animal Blood\''),
(25774, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 6000, 9000, 0, 0, 11, 32918, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rockfang - In Combat - Cast \'Chilling Howl\'');

-- Gammothra the Tormentor SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25789 AND `id` IN (1,2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25789, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 10000, 12000, 0, 0, 11, 50413, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gammothra the Tormentor - In Combat - Cast \'Magnataur Charge\''),
(25789, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 6000, 10000, 0, 0, 11, 50410, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gammothra the Tormentor - In Combat - Cast \'Tusk Strike\'');

-- High Deathpriest Isidorus SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26171;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26171);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26171, 0, 0, 0, 1, 0, 100, 0, 30000, 50000, 170000, 200000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Deathpriest Isidorus - Out of Combat - Say Line 0');

-- Lurid SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26185;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26185);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26185, 0, 0, 0, 1, 0, 100, 0, 30000, 70000, 170000, 200000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lurid - Out of Combat - Say Line 0'),
(26185, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lurid - On Reset - Set Reactstate Defensive'),
(26185, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lurid - On Aggro - Say Line 1');

-- Fleeing Cultist SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26189;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26189);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26189, 0, 0, 0, 11, 0, 33, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fleeing Cultist - On Respawn - Say Line 0');

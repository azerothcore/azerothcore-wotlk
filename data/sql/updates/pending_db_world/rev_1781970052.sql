
-- Delete Movement Flags (added via SAI).
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 28465);

-- Update SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28465;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28465);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28465, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Aggro - Dismount'),
(28465, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Aggro - Set Disable Gravity Off'),
(28465, 0, 2, 3, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 43, 0, 9074, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Reset - Mount To Model 9074'),
(28465, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 61, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Reset - Set Swim On'),
(28465, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Reset - Set Disable Gravity On'),
(28465, 0, 5, 0, 0, 0, 100, 0, 5000, 5000, 16000, 16000, 0, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - In Combat - Cast \'Strike\''),
(28465, 0, 6, 0, 0, 0, 100, 0, 4000, 14000, 50000, 60000, 0, 0, 11, 51951, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - In Combat - Cast \'Rabies\'');

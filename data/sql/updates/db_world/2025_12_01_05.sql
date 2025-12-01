-- DB update 2025_12_01_04 -> 2025_12_01_05
--
-- Wolfsbane Root (189313) - Despawn on use via SmartAI
-- Closes https://github.com/azerothcore/azerothcore-wotlk/issues/23904
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 189313;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 189313 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(189313, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wolfsbane Root - On State Changed - Despawn');

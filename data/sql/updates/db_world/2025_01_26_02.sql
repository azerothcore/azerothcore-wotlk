-- DB update 2025_01_26_01 -> 2025_01_26_02
--
-- Updates the Action from "Action Invoker" (7) to "Self" (1).
UPDATE `smart_scripts` SET `target_type` = 1 WHERE `entryorguid` = 9456 AND `source_type` = 0 AND `id` = 1;

-- Adds Strike sniffed from: 4.4.1.58158 and 1.15.5.57979
DELETE FROM `smart_scripts` WHERE `entryorguid` = 9456 AND `source_type` = 0 AND `id` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9456, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 4000, 6000, 0, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Krom\'zar - In Combat - Cast \'Strike\'');

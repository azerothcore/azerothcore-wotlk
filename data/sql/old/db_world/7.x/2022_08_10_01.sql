-- DB update 2022_08_10_00 -> 2022_08_10_01
--
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 15277 AND `id`=12;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15277, 0, 12, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 27630, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anubisath Defender - On Just Died - Cast \'Serverside - Drop Obsidian\'');

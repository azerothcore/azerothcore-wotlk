INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622104586099236800');

-- Swap scripts called on gossip option selected
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27990) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27990, 0, 0, 0, 62, 0, 100, 0, 10199, 0, 0, 0, 0, 80, 2799000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Krasus - On Gossip Option 0 Selected - Run Script (No Repeat) (Dungeon)'),
(27990, 0, 1, 0, 62, 0, 100, 0, 10199, 1, 0, 0, 0, 80, 2799001, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Krasus - On Gossip Option 1 Selected - Run Script (No Repeat) (Dungeon)');

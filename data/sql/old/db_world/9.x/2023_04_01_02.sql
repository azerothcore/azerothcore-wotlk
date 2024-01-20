-- DB update 2023_04_01_01 -> 2023_04_01_02
--
DELETE FROM `event_scripts` WHERE `id` IN (14592, 14593, 14595);

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (182196, 182197, 182198);
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` IN (182196, 182197, 182198));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(182196, 1, 0, 0, 71, 0, 100, 1, 14592, 0, 0, 0, 0, 12, 22890, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -108.252, -510.302, 21.4761, 2.44346, 'Arcane Container - On Event 14592 Inform - Summon Creature \'First Fragment Guardian\''),
(182197, 1, 0, 0, 71, 0, 100, 1, 14593, 0, 0, 0, 0, 12, 22891, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 13.49, -307.87, -66, 3.12, 'Arcane Container - On Event 14593 Inform - Summon Creature \'Second Fragment Guardian\''),
(182198, 1, 0, 0, 71, 0, 100, 1, 14595, 0, 0, 0, 0, 12, 22892, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 312.72, -19.24, 22.44, 2.12, 'Arcane Container - On Event 14595 Inform - Summon Creature \'Third Fragment Guardian\'');

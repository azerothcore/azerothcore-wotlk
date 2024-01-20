-- DB update 2023_07_08_02 -> 2023_07_08_03
-- Fix Un'goro's Crystal Pylons --
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (164955, 164956, 164957);

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` IN (164955, 164956, 164957));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(164955, 1, 0, 1, 62, 0, 100, 0, 2177, 0, 0, 0, 0, 15, 4285, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Northern Crystal Pylon - On Gossip Option 0 Selected - Quest Credit \'The Northern Pylon\''),
(164955, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Northern Crystal Pylon - On Gossip Option 0 Selected - Close Gossip'),
(164956, 1, 0, 1, 62, 0, 100, 0, 2179, 0, 0, 0, 0, 15, 4288, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Western Crystal Pylon - On Gossip Option 0 Selected - Quest Credit \'The Western Pylon\''),
(164956, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Western Crystal Pylon - On Gossip Option 0 Selected - Close Gossip'),
(164957, 1, 0, 1, 62, 0, 100, 0, 2178, 0, 0, 0, 0, 15, 4287, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Eastern Crystal Pylon - On Gossip Option 0 Selected - Quest Credit \'The Eastern Pylon\''),
(164957, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Eastern Crystal Pylon - On Gossip Option 0 Selected - Close Gossip');

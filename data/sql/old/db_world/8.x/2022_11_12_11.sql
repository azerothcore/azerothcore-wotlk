-- DB update 2022_11_12_10 -> 2022_11_12_11
-- Closes gossip on selecting last option
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10740;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10740) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10740, 0, 0, 0, 62, 0, 100, 0, 3064, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Awbee - On Gossip Option 0 Selected - Close Gossip');

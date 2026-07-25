-- DB update 2025_10_12_00 -> 2025_10_12_01
--
-- With this smart script set, the worm will seek the first player within 18 yards to attack, with no regard to the player's level. Being outside of 18 yards when killing a Rotted One will avoid this behavior.
-- Smart Script #2 will ensure the mob dies after 30 seconds, which is how long they are supposed to live.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2462;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 2462);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2462, 0, 0, 0, 101, 0, 100, 0, 0, 18, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 18, 0, 0, 0, 0, 0, 0, 0, 'Flesh Eating Worm - On 0 or More Players in Range - Start Attacking'),
(2462, 0, 1, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flesh Eating Worm - In Combat - Kill Self');

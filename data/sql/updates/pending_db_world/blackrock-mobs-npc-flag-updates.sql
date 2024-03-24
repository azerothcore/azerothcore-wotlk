
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9499;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9499) AND (`source_type` = 0) AND (`id` IN (13, 14));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9499, 0, 13, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 83, 130, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plugger Spazzring - On Aggro - Remove Npc Flags Questgiver & Vendor'),
(9499, 0, 14, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 82, 130, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plugger Spazzring - On Reset - Add Npc Flags Questgiver & Vendor');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9545;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9545);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9545, 0, 0, 0, 105, 0, 100, 0, 3000, 5000, 5000, 8000, 0, 5, 11, 15610, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - In Combat - Cast \'Kick\''),
(9545, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 14822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Between 0-30% Health - Cast \'Drunken Rage\' (No Repeat)'),
(9545, 0, 2, 0, 1, 0, 55, 0, 7000, 15000, 7000, 15000, 0, 0, 10, 1, 4, 11, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - OOC - Play Random Emotes'),
(9545, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Data set - Start Attack'),
(9545, 0, 4, 0, 38, 0, 100, 512, 1, 4, 0, 0, 0, 0, 80, 954700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Data set - Action list'),
(9545, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Aggro - Remove Npc Flags Gossip'),
(9545, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reset - Add Npc Flags Gossip');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9547;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9547) AND (`source_type` = 0) AND (`id` IN (6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9547, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Aggro - Remove Npc Flags Gossip'),
(9547, 0, 7, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Add Npc Flags Gossip');


UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28067;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28067) AND (`source_type` = 0) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28067, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Brewer - On Aggro - Remove Npc Flags Gossip'),
(28067, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Brewer - On Reset - Add Npc Flags Gossip');


UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9554;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9554) AND (`source_type` = 0) AND (`id` IN (2, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9554, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Aggro - Remove Npc Flags Gossip'),
(9554, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Reset - Add Npc Flags Gossip');


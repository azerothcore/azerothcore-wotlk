-- DB update 2026_10_13_10 -> 2026_10_14_00
-- BRD patrons use the instance script; keep the mug's Morja and Oozeling interactions outside BRD.
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 165578;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 165578) AND (`source_type` = 1);
INSERT INTO `smart_scripts` (
`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
`event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
`target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(165578, 1, 0, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 14871, 5, 0, 0, 0, 0, 0, 0,
'Dark Iron Ale Mug - On Just Created - Set Data to Morja'),
(165578, 1, 1, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 15429, 20, 0, 0, 0, 0, 0, 0,
'Dark Iron Ale Mug - On Just Created - Set Data to Disgusting Oozeling');

-- Grim Patron
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9545) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9545, 0, 0, 0, 105, 0, 25, 0, 3000, 5000, 5000, 8000, 0, 5, 11, 15610, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - In Combat - Cast \'Kick\''),
(9545, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 14822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Between 0-30% Health - Cast \'Drunken Rage\' (No Repeat)'),
(9545, 0, 2, 0, 1, 0, 55, 0, 7000, 15000, 7000, 15000, 0, 0, 10, 1, 4, 11, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - OOC - Play Random Emotes'),
(9545, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Data Set 1 1 - Start Attack'),
(9545, 0, 4, 0, 38, 0, 100, 512, 1, 4, 0, 0, 0, 0, 80, 954501, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Data Set 1 4 - Wait Before Moving to Dark Iron Ale Mug'),
(9545, 0, 5, 8, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Aggro - Remove Npc Flags Gossip'),
(9545, 0, 6, 8, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reset - Add Npc Flags Gossip'),
(9545, 0, 7, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 954500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reached Dark Iron Ale Mug - Run Action List'),
(9545, 0, 8, 14, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Linked Event - Clear Dark Iron Ale State'),
(9545, 0, 10, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reset - Reform Patron Group'),
(9545, 0, 11, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reached Home - Restore Emote State'),
(9545, 0, 12, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reset - Cancel Drink Sequence'),
(9545, 0, 13, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Death - Cancel Drink Sequence'),
(9545, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Linked Event - Cancel Drink Sequence');

-- Guzzling Patron
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9547) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9547, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 15000, 15000, 0, 0, 11, 14868, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - In Combat - Cast \'Curse of Agony\''),
(9547, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 3000, 4000, 0, 0, 11, 20825, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - In Combat - Cast \'Shadow Bolt\''),
(9547, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 14822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Between 0-30% Health - Cast \'Drunken Rage\' (No Repeat)'),
(9547, 0, 3, 0, 1, 0, 55, 0, 7000, 15000, 7000, 15000, 0, 0, 10, 1, 4, 11, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - OOC - Play Random Emotes'),
(9547, 0, 4, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Data Set 1 1 - Start Attack'),
(9547, 0, 5, 0, 38, 0, 100, 512, 1, 4, 0, 0, 0, 0, 80, 954701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Data Set 1 4 - Wait Before Moving to Dark Iron Ale Mug'),
(9547, 0, 6, 9, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Aggro - Remove Npc Flags Gossip'),
(9547, 0, 7, 9, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Add Npc Flags Gossip'),
(9547, 0, 8, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 954700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reached Dark Iron Ale Mug - Run Action List'),
(9547, 0, 9, 15, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Linked Event - Clear Dark Iron Ale State'),
(9547, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Reform Patron Group'),
(9547, 0, 12, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reached Home - Restore Emote State'),
(9547, 0, 13, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Cancel Drink Sequence'),
(9547, 0, 14, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Death - Cancel Drink Sequence'),
(9547, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Linked Event - Cancel Drink Sequence');

-- Hammered Patron
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9554) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9554, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 8000, 0, 0, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - In Combat - Cast \'Backhand\''),
(9554, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 14822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - Between 0-30% Health - Cast \'Drunken Rage\' (No Repeat)'),
(9554, 0, 2, 7, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Aggro - Remove Npc Flags Gossip'),
(9554, 0, 3, 0, 1, 0, 55, 0, 7000, 15000, 7000, 15000, 0, 0, 10, 1, 4, 11, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - OOC - Play Random Emotes'),
(9554, 0, 4, 0, 38, 0, 100, 512, 1, 4, 0, 0, 0, 0, 80, 955401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Data Set 1 4 - Wait Before Moving to Dark Iron Ale Mug'),
(9554, 0, 5, 7, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Reset - Add Npc Flags Gossip'),
(9554, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 955400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Reached Dark Iron Ale Mug - Run Action List'),
(9554, 0, 7, 13, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Linked Event - Clear Dark Iron Ale State'),
(9554, 0, 9, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Reset - Reform Patron Group'),
(9554, 0, 10, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Reached Home - Restore Emote State'),
(9554, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Reset - Cancel Drink Sequence'),
(9554, 0, 12, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Death - Cancel Drink Sequence'),
(9554, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - On Linked Event - Cancel Drink Sequence');

-- Grim Patron guid 48172
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -48172) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-48172, 0, 0, 0, 105, 0, 100, 0, 3000, 5000, 5000, 8000, 0, 5, 11, 15610, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - In Combat - Cast \'Kick\''),
(-48172, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 14822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Between 0-30% Health - Cast \'Drunken Rage\' (No Repeat)'),
(-48172, 0, 2, 0, 1, 0, 55, 0, 7000, 15000, 7000, 15000, 0, 0, 10, 1, 4, 11, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - OOC - Play Random Emotes'),
(-48172, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Data Set 1 1 - Start Attack'),
(-48172, 0, 4, 0, 38, 0, 100, 512, 1, 4, 0, 0, 0, 0, 80, 954501, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Data Set 1 4 - Wait Before Moving to Dark Iron Ale Mug'),
(-48172, 0, 5, 8, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Aggro - Remove Npc Flags Gossip'),
(-48172, 0, 6, 8, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reset - Add Npc Flags Gossip'),
(-48172, 0, 7, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 954500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reached Dark Iron Ale Mug - Run Action List'),
(-48172, 0, 8, 16, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Linked Event - Clear Dark Iron Ale State'),
(-48172, 0, 10, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reset - Reform Patron Group'),
(-48172, 0, 11, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reached Home - Restore Emote State'),
(-48172, 0, 12, 13, 1, 0, 100, 0, 30000, 30000, 55000, 60000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - OOC - Say text1'),
(-48172, 0, 13, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 9500, 50, 0, 0, 0, 0, 0, 0, 'Grim Patron - OOC - Set data'),
(-48172, 0, 14, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Reset - Cancel Drink Sequence'),
(-48172, 0, 15, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Death - Cancel Drink Sequence'),
(-48172, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - On Linked Event - Cancel Drink Sequence');

-- Guzzling Patron guid 90884
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -90884) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-90884, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 15000, 15000, 0, 0, 11, 14868, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - In Combat - Cast \'Curse of Agony\''),
(-90884, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 3000, 4000, 0, 0, 11, 20825, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - In Combat - Cast \'Shadow Bolt\''),
(-90884, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 14822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Between 0-30% Health - Cast \'Drunken Rage\' (No Repeat)'),
(-90884, 0, 3, 0, 1, 0, 55, 0, 7000, 15000, 7000, 15000, 0, 0, 10, 1, 4, 11, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - OOC - Play Random Emotes'),
(-90884, 0, 4, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Data Set 1 1 - Start Attack'),
(-90884, 0, 5, 0, 38, 0, 100, 512, 1, 4, 0, 0, 0, 0, 80, 954701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Data Set 1 4 - Wait Before Moving to Dark Iron Ale Mug'),
(-90884, 0, 6, 9, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Aggro - Remove Npc Flags Gossip'),
(-90884, 0, 7, 9, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Add Npc Flags Gossip'),
(-90884, 0, 8, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 954700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reached Dark Iron Ale Mug - Run Action List'),
(-90884, 0, 9, 17, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Linked Event - Clear Dark Iron Ale State'),
(-90884, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Reform Patron Group'),
(-90884, 0, 12, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reached Home - Restore Emote State'),
(-90884, 0, 13, 14, 1, 0, 100, 0, 150000, 150000, 12000, 180000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - OOC - Say text1'),
(-90884, 0, 14, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 9500, 50, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - OOC - Set data'),
(-90884, 0, 15, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Cancel Drink Sequence'),
(-90884, 0, 16, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Death - Cancel Drink Sequence'),
(-90884, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Linked Event - Cancel Drink Sequence');

-- Guzzling Patron guid 91064
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -91064) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-91064, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 15000, 15000, 0, 0, 11, 14868, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - In Combat - Cast \'Curse of Agony\''),
(-91064, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 3000, 4000, 0, 0, 11, 20825, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - In Combat - Cast \'Shadow Bolt\''),
(-91064, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 14822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Between 0-30% Health - Cast \'Drunken Rage\' (No Repeat)'),
(-91064, 0, 3, 0, 1, 0, 55, 0, 7000, 15000, 7000, 15000, 0, 0, 10, 1, 4, 11, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - OOC - Play Random Emotes'),
(-91064, 0, 4, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Data Set 1 1 - Start Attack'),
(-91064, 0, 5, 0, 38, 0, 100, 512, 1, 4, 0, 0, 0, 0, 80, 954701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Data Set 1 4 - Wait Before Moving to Dark Iron Ale Mug'),
(-91064, 0, 6, 9, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Aggro - Remove Npc Flags Gossip'),
(-91064, 0, 7, 9, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Add Npc Flags Gossip'),
(-91064, 0, 8, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 954700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reached Dark Iron Ale Mug - Run Action List'),
(-91064, 0, 9, 17, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Linked Event - Clear Dark Iron Ale State'),
(-91064, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Reform Patron Group'),
(-91064, 0, 12, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reached Home - Restore Emote State'),
(-91064, 0, 13, 14, 1, 0, 100, 0, 200000, 200000, 550000, 600000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - OOC - Say text1'),
(-91064, 0, 14, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 9500, 50, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - OOC - Set data'),
(-91064, 0, 15, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Reset - Cancel Drink Sequence'),
(-91064, 0, 16, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Death - Cancel Drink Sequence'),
(-91064, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 0, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - On Linked Event - Cancel Drink Sequence');

-- Wait before approaching the mug; reset, death and aggro cancel these action lists.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 954501) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(954501, 9, 0, 0, 0, 0, 100, 0, 2800, 3300, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Action List - Move to Dark Iron Ale Mug');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 954701) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(954701, 9, 0, 0, 0, 0, 100, 0, 2800, 3300, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Action List - Move to Dark Iron Ale Mug');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 955401) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(955401, 9, 0, 0, 0, 0, 100, 0, 2800, 3300, 0, 0, 0, 0, 69, 1, 0, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - Action List - Move to Dark Iron Ale Mug');

-- Patron drink sequences: Drinking itself triggers Drunken Rage after its full 15 seconds.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 954500) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(954500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Action List - Play Eat Emote'),
(954500, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Action List - Consume Dark Iron Ale Mug'),
(954500, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Action List - Leave Patron Group'),
(954500, 9, 4, 0, 0, 0, 100, 0, 1500, 2800, 0, 0, 0, 0, 11, 14823, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Action List - Cast Drinking'),
(954500, 9, 8, 0, 0, 0, 100, 0, 16200, 16200, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Action List - Clear Dark Iron Ale State'),
(954500, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Action List - Return Home');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 954700) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(954700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Action List - Play Eat Emote'),
(954700, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Action List - Consume Dark Iron Ale Mug'),
(954700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Action List - Leave Patron Group'),
(954700, 9, 4, 0, 0, 0, 100, 0, 1500, 2800, 0, 0, 0, 0, 11, 14823, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Action List - Cast Drinking'),
(954700, 9, 8, 0, 0, 0, 100, 0, 16200, 16200, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Action List - Clear Dark Iron Ale State'),
(954700, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Action List - Return Home');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 955400) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(955400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - Action List - Play Eat Emote'),
(955400, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - Action List - Consume Dark Iron Ale Mug'),
(955400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - Action List - Leave Patron Group'),
(955400, 9, 4, 0, 0, 0, 100, 0, 1500, 2800, 0, 0, 0, 0, 11, 14823, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - Action List - Cast Drinking'),
(955400, 9, 8, 0, 0, 0, 100, 0, 16200, 16200, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - Action List - Clear Dark Iron Ale State'),
(955400, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 35, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - Action List - Return Home');

DELETE FROM `creature_text` WHERE `CreatureID` IN (9545, 9547, 9554) AND `GroupID` = 1;

-- DB update 2023_03_01_07 -> 2023_03_02_00
-- Gurthock Gossip
DELETE FROM `gossip_menu` WHERE (`MenuID` = 7699);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7699, 9394),
(7699, 9403);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 7699) AND (`SourceEntry` IN (9394, 9403));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7699, 9394, 0, 0, 8, 0, 9977, 0, 0, 1, 0, 0, '', 'Show text if player does not have quest \'The Ring of Blood: The Final Challenge\' rewarded'),
(14, 7699, 9403, 0, 0, 8, 0, 9977, 0, 0, 0, 0, 0, '', 'Show text if player has quest \'The Ring of Blood: The Final Challenge\' rewarded');

-- Minor Adjustments
DELETE FROM `creature_template_addon` WHERE (`entry` IN (18400, 18402));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(18400, 0, 0, 0, 0, 0, 0, '21911'),
(18402, 0, 0, 0, 1, 0, 0, '');

UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 18399);

UPDATE `creature_text` SET `Emote`=15 WHERE `CreatureID`=18399 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `Type`=12, `Emote`=15 WHERE `CreatureID`=18402 AND `GroupID`=0 AND `ID`=0;

UPDATE `creature` SET `spawntimesecs`=1 WHERE `guid`=48191 AND `id1`=18069;

-- Add Boss immunities to challengers
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854271 WHERE (`entry` IN (18398, 18399, 18400, 18401, 18402));

-- Skra'gath Text
DELETE FROM `creature_text` WHERE `CreatureID`=18401;
INSERT INTO `creature_text` (`CreatureID`, `BroadcastTextId`, `GroupID`, `ID`, `Text`, `Type`, `comment`) VALUES
(18401, 15472, 0, 0, 'Closer... Come closer... See what the void brings!', 14, 'Skra\'gath'),
(18401, 17110, 1, 0, '%s absorbs the holy energy of the attack.', 16, 'Skra\'gath'),
(18401, 17105, 2, 0, '%s absorbs the fire energy of the attack.', 16, 'Skra\'gath'),
(18401, 17107, 3, 0, '%s absorbs the nature energy of the attack.', 16, 'Skra\'gath'),
(18401, 17106, 4, 0, '%s absorbs the frost energy of the attack.', 16, 'Skra\'gath'),
(18401, 17108, 5, 0, '%s absorbs the shadow energy of the attack.', 16, 'Skra\'gath'),
(18401, 17109, 6, 0, '%s absorbs the arcane energy of the attack.', 16, 'Skra\'gath');

-- Text for Mogor and Gurgthock
DELETE FROM `creature_text` WHERE `CreatureID` IN (18069, 18398, 18471);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18398, 0, 0, 'Brokentoe prepares to charge.', 41, 0, 100, 0, 0, 0, 15438, 0, 'Brokentoe'),
(18069, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 38630, 0, 'Mogor'),
(18069, 1, 0, 'Dat was poop! Mogor could put up much better fight den dat!', 14, 0, 100, 15, 0, 0, 15470, 0, 'Mogor'),
(18069, 2, 0, 'Mogor not impressed! Skra\'gath wuz made of da air and shadow! Soft like da squishy orcies!', 14, 0, 100, 15, 0, 0, 15474, 0, 'Mogor'),
(18069, 3, 0, 'WUT!? UNPOSSIBLE!! You fight Mogor now! Mogor destroy!', 14, 0, 100, 15, 0, 0, 15477, 0, 'Mogor'),
(18069, 4, 0, 'Now you face da true champion! I give you chance to run away little one. Run away now before Mogor decim... destyor... Run away before Mogor KILL!', 14, 0, 100, 0, 0, 0, 15478, 0, 'Mogor'),
(18069, 5, 0, 'No more chances! Now you pay da ogre!', 14, 0, 100, 15, 0, 0, 15479, 0, 'Mogor'),
(18069, 6, 0, 'No more nice ogre! You hurt Mogor!!', 14, 0, 100, 0, 0, 0, 15483, 0, 'Mogor'),
(18471, 0 , 0, 'Get in the Ring of Blood, $n. The fight is about to start!', 12, 0, 100, 1, 0, 0, 15441, 0, 'Gurgthock'),
(18471, 1 , 0, 'The battle is about to begin! $n versus the ferocious clefthoof, Brokentoe!', 14, 0, 100, 15, 0, 0, 15439, 0, 'Gurgthock'),
(18471, 2 , 0, '$n has defeated Brokentoe!', 14, 0, 100, 15, 0, 0, 15442, 0, 'Gurgthock'),
(18471, 3 , 0, 'The battle is about to begin! The unmerciful Murkblood twins versus $n!', 14, 0, 100, 15, 0, 0, 15461, 0, 'Gurgthock'),
(18471, 4 , 0, 'Unbelievable! $n has defeated the Murkblood twins!', 14, 0, 100, 15, 0, 0, 15462, 0, 'Gurgthock'),
(18471, 5 , 0, 'Hailing from the mountains of Blade\'s Edge comes Rokdar the Sundered Lord! $n is in for the fight of $g his:her, life.', 14, 0, 100, 15, 0, 0, 15467, 0, 'Gurgthock'),
(18471, 6 , 0, 'From parts unknown: Skra\'gath! Can $n possibly survive the onslaught of void energies?', 14, 0, 100, 15, 0, 0, 15473, 0, 'Gurgthock'),
(18471, 7 , 0, 'This is the moment we\'ve all been waiting for! The Warmaul champion is about to make his first showing at the Ring of Blood in weeks! Will $n go down in defeat as easily as the champion\'s other opponents? We shall see...', 14, 0, 100, 15, 0, 0, 15475, 0, 'Gurgthock'),
(18471, 8 , 0, '$n is victorious once more!', 14, 0, 100, 15, 0, 0, 15469, 0, 'Gurgthock'),
(18471, 9 , 1, 'All that\'s left of $n is a red stain on the floor!', 14, 0, 100, 15, 0, 0, 15485, 0, 'Gurgthock'),
(18471, 9, 0, '$n went down like a sack of orc skulls!', 14, 0, 100, 15, 0, 0, 15484, 0, 'Gurgthock'),
(18471, 10, 0, 'Mogor has challenged you. You have to accept! Get in the ring if you are ready to fight.', 12, 0, 100, 1, 0, 0, 15480, 0, 'Gurgthock'),
(18471, 11, 0, 'For the first time in the Ring of Blood\'s history, Mogor has chosen to exercise his right of battle! On this wartorn ground, $n will face Mogor, hero of the Warmaul!', 14, 0, 100, 15, 0, 0, 15481, 0, 'Gurgthock'),
(18471, 12, 0, '$n has defeated the hero of the Warmaul, Mogor! All hail $n!', 14, 0, 100, 15, 0, 0, 15482, 2, 'Gurgthock'),
(18471, 13, 0, '$n has been defeated!', 14, 0, 100, 15, 0, 0, 15443, 2, 'Gurgthock');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18471);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18471, 0, 0 , 0, 19, 0, 100, 0, 9962, 0, 0, 0, 0, 80, 1847100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Ring of Blood: Brokentoe\' Taken - Run Script'),
(18471, 0, 1 , 0, 19, 0, 100, 0, 9967, 0, 0, 0, 0, 80, 1847103, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Ring of Blood: The Blue Brothers\' Taken - Run Script'),
(18471, 0, 2 , 0, 19, 0, 100, 0, 9970, 0, 0, 0, 0, 80, 1847106, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Ring of Blood: Rokdar the Sundered Lord\' Taken - Run Script'),
(18471, 0, 3 , 0, 19, 0, 100, 0, 9972, 0, 0, 0, 0, 80, 1847109, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Ring of Blood: Skra\'gath\' Taken - Run Script'),
(18471, 0, 4 , 0, 19, 0, 100, 0, 9973, 0, 0, 0, 0, 80, 1847112, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Ring of Blood: The Warmaul Champion\' Taken - Run Script'),
(18471, 0, 5 , 0, 19, 0, 100, 0, 9977, 0, 0, 0, 0, 80, 1847115, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Quest \'The Ring of Blood: The Final Challenge\' Taken - Run Script'),
(18471, 0, 6 , 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1847101, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 1 1 - Run Brokentoe Success Script'),
(18471, 0, 7 , 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 80, 1847102, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 2 2 - Run Brokentoe Failure Script'),
(18471, 0, 8 , 9, 77, 0, 100, 0, 1, 2, 0, 0, 0, 80, 1847104, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On 2 Twins Killed - Run Murkblood Twins Success Script'),
(18471, 0, 9 , 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On 2 Twins Killed - Reset Counter'),
(18471, 0, 10, 0, 38, 0, 100, 0, 5, 5, 0, 0, 0, 80, 1847105, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 5 5 - Run Murkblood Twins Failure Script'),
(18471, 0, 11, 0, 38, 0, 100, 0, 7, 7, 0, 0, 0, 80, 1847107, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 7 7 - Run Rokdar Success Script'),
(18471, 0, 12, 0, 38, 0, 100, 0, 8, 8, 0, 0, 0, 80, 1847108, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 8 8 - Run Rokdar Failure Script'),
(18471, 0, 13, 0, 38, 0, 100, 0, 10, 10, 0, 0, 0, 80, 1847110, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 10 10 - Run Skra\'gath Success Script'),
(18471, 0, 14, 0, 38, 0, 100, 0, 11, 11, 0, 0, 0, 80, 1847111, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 11 11 - Run Skra\'gath Failure Script'),
(18471, 0, 15, 0, 38, 0, 100, 0, 13, 13, 0, 0, 0, 80, 1847113, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 13 13 - Run Champion Success Script'),
(18471, 0, 16, 0, 38, 0, 100, 0, 14, 14, 0, 0, 0, 80, 1847114, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 14 14 - Run Champion Failure Script'),
(18471, 0, 17, 0, 38, 0, 100, 0, 16, 16, 0, 0, 0, 80, 1847116, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 16 16 - Run Mogor Success Script'),
(18471, 0, 18, 0, 38, 0, 100, 0, 17, 17, 0, 0, 0, 80, 1847117, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - On Data Set 17 17 - Run Mogor Failure Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 1847100 AND 1847117);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Brokentoe Spawn
(1847100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Spawn Script - Store Targetlist Invoker'),
(1847100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Spawn Script - Store Targetlist Invoker Party'),
(1847100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Spawn Script - Remove Npc Flags Questgiver'),
(1847100, 9, 3, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Spawn Script - Say Line 0'),
(1847100, 9, 4, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Spawn Script - Say Line 1'),
(1847100, 9, 5, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 12, 18398, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, -709.046, 7882.44, 46.0542, 1.98968, 'Gurgthock - Brokentoe Spawn Script - Summon Creature \'Brokentoe\''),
-- Brokentoe Success
(1847101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Success Script - Say Line 2'),
(1847101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Success Script - Add Npc Flags Questgiver'),
(1847101, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 15, 9962, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Success Script - Quest Credit \'The Ring of Blood: Brokentoe\''),
-- Brokentoe Failure
(1847102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 9, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Failure Script - Say Line 9'),
(1847102, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Failure Script - Add Npc Flags Questgiver'),
(1847102, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 6, 9962, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Brokentoe Failure Script - Fail Quest \'The Ring of Blood: Brokentoe\''),
-- Murkblood Twins Spawn
(1847103, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Spawn Script - Store Targetlist Invoker'),
(1847103, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Spawn Script - Store Targetlist Invoker Party for Quest Credit'),
(1847103, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Spawn Script - Remove Npc Flags Questgiver'),
(1847103, 9, 3, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Spawn Script - Say Line 0'),
(1847103, 9, 4, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Spawn Script - Say Line 3'),
(1847103, 9, 5, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 12, 18399, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, -718.036, 7871.62, 45.2835, 1.5708, 'Gurgthock - Murkblood Twins Spawn Script - Summon Creature \'Murkblood Twin\''),
(1847103, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 18399, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, -696.431, 7883.26, 47.4277, 2.47837, 'Gurgthock - Murkblood Twins Spawn Script - Summon Creature \'Murkblood Twin\''),
-- (1847103, 9, 7, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 18399, 100, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Spawn Script - Set Data 1 1 on Left Twin'),
-- (1847103, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 18399, 0, 100, 1, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Spawn Script - Set Data 2 2 on Right Twin'),
(1847103, 9, 7, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 18399, 0, 100, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Spawn Script - Send Target 1 to both Twins'), -- Attack Start on Stored Target within 1200ms if not already in combat
-- Murkblood Twins Success
(1847104, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 4, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Success Script - Say Line 4'),
(1847104, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Success Script - Add Npc Flags Questgiver'),
(1847104, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 15, 9967, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Success Script - Quest Credit \'The Ring of Blood: The Blue Brothers\''),
-- Murkblood Twins Failure
(1847105, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 9, 18399, 0, 200, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Failure Script - Despawn Twins for Safety'),
(1847105, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 9, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Failure Script - Say Line 9'),
(1847105, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Failure Script - Add Npc Flags Questgiver'),
(1847105, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 6, 9967, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Failure Script - Fail Quest \'The Ring of Blood: The Blue Brothers\''),
(1847105, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Murkblood Twins Failure Script - Reset Counter'),
-- Rokdar Spawn
(1847106, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Spawn Script - Store Targetlist Invoker'),
(1847106, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Spawn Script - Store Targetlist Invoker Party'),
(1847106, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Spawn Script - Remove Npc Flags Questgiver'),
(1847106, 9, 3, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Spawn Script - Say Line 0'),
(1847106, 9, 4, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 1, 5, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Spawn Script - Say Line 5'),
(1847106, 9, 5, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 12, 18400, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, -709.567, 7882.856, 46.109646, 1.9024088382720947, 'Gurgthock - Rokdar Spawn Script - Summon Creature \'Rokdar the Sundered Lord\''),
(1847106, 9, 6, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 18400, 100, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Spawn Script - Send Stored Target to Rokdar'),
(1847106, 9, 7, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 18400, 100, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Spawn Script - Set Data 1 1 on Rokdar'), -- Talk and Attack Stored Target within 2000ms if not already in combat
-- Rokdar Success
(1847107, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 8, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Success Script - Say Line 8'),
(1847107, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Success Script - Add Npc Flags Questgiver'),
(1847107, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 15, 9970, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Success Script - Quest Credit \'The Ring of Blood: Rokdar the Sundered Lord\''),
(1847107, 9, 3, 0, 0, 0, 100, 0, 5200, 5200, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 48191, 18069, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Success Script - Mogor Say Line 1'),
-- Rokdar Failure
(1847108, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 9, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Failure Script - Say Line 9'),
(1847108, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Failure Script - Add Npc Flags Questgiver'),
(1847108, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 6, 9970, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Rokdar Failure Script - Fail Quest \'The Ring of Blood: Rokdar the Sundered Lord\''),
-- Skra'gath Spawn
(1847109, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Spawn Script - Store Targetlist Invoker'),
(1847109, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Spawn Script - Store Targetlist Invoker Party'),
(1847109, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Spawn Script - Remove Npc Flags Questgiver'),
(1847109, 9, 3, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Spawn Script - Say Line 0'),
(1847109, 9, 4, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 1, 6, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Spawn Script - Say Line 6'),
(1847109, 9, 5, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 12, 18401, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, -708.91364, 7883.2563, 46.199944, 1.832595705986023, 'Gurgthock - Skra\'gath Spawn Script - Summon Creature \'Skra\'gath\''),
(1847109, 9, 6, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 18401, 100, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Spawn Script - Send Target 1'),
(1847109, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 18401, 100, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Spawn Script - Set Data 1 1 on Skra\'gath'),
-- Skra'gath Success
(1847110, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 8, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Success Script - Say Line 8'),
(1847110, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Success Script - Add Npc Flags Questgiver'),
(1847110, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 15, 9972, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Success Script - Quest Credit \'The Ring of Blood: Skra\'gath\''),
(1847110, 9, 3, 0, 0, 0, 100, 0, 5200, 5200, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 10, 48191, 18069, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Success Script - Mogor Say Line 2'),
-- Skra'gath Failure
(1847111, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 9, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Failure Script - Say Line 9'),
(1847111, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Failure Script - Add Npc Flags Questgiver'),
(1847111, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 6, 9972, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Skra\'gath Failure Script - Fail Quest \'The Ring of Blood: Skra\'gath\''),
-- Champion Spawn
(1847112, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Spawn Script - Store Targetlist Invoker'),
(1847112, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Spawn Script - Store Targetlist Invoker Party'),
(1847112, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Spawn Script - Remove Npc Flags Questgiver'),
(1847112, 9, 3, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Spawn Script - Say Line 0'),
(1847112, 9, 4, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 1, 7, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Spawn Script - Say Line 7'),
(1847112, 9, 5, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 12, 18402, 6, 5000, 0, 0, 0, 8, 0, 0, 0, 0, -705.97473, 7866.7163, 45.06112, 1.5707963705062866, 'Gurgthock - Champion Spawn Script - Summon Creature \'Warmaul Champion\''),
(1847112, 9, 6, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 18402, 100, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Spawn Script - Send Target 1'),
(1847112, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 18402, 100, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Spawn Script - Set Data 1 1 on Champion'),
-- Champion Success
(1847113, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 8, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Success Script - Say Line 8'),
(1847113, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Success Script - Add Npc Flags Questgiver'),
(1847113, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 15, 9973, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Success Script - Quest Credit \'The Ring of Blood: The Warmaul Champion\''),
(1847113, 9, 3, 0, 0, 0, 100, 0, 5200, 5200, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 10, 48191, 18069, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Success Script - Mogor Say Line 3'),
-- Champion Failure
(1847114, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 9, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Failure Script - Say Line 9'),
(1847114, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Failure Script - Add Npc Flags Questgiver'),
(1847114, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 6, 9973, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Champion Failure Script - Fail Quest \'The Ring of Blood: The Warmaul Champion\''),
-- Mogor Start
(1847115, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Start Script - Store Targetlist Invoker'),
(1847115, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Start Script - Store Targetlist Invoker Party'),
(1847115, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Start Script - Remove Npc Flags Questgiver'),
(1847115, 9, 3, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 1, 10, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Start Script - Say Line 10'),
(1847115, 9, 4, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 1, 11, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Start Script - Say Line 11'),
(1847115, 9, 5, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 48191, 18069, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Start Script - Set Data 1 1'),
(1847115, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 10, 48191, 18069, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Start Script - Send Target 1'),
-- Mogor Success
(1847116, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 12, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Success Script - Say Line 12'),
(1847116, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 15, 9977, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Success Script - Quest Credit \'The Ring of Blood: The Final Challenge\''),
(1847116, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Success Script - Add Npc Flags Questgiver'),
-- Mogor Failure
(1847117, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 13, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Failure Script - Say Line 13'),
(1847117, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Failure Script - Add Npc Flags Questgiver'),
(1847117, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 6, 9977, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Failure Script - Fail Quest \'The Ring of Blood: The Final Challenge\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (18398, 18399, 18400, 18401, 18402));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18398, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 9000, 11000, 0, 11, 32023, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Brokentoe - In Combat - Cast \'Hoof Stomp\''),
(18398, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Brokentoe - On Just Died - Set Data 1 1 on Gurgthock'),
(18398, 0, 2, 3, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Brokentoe - Out of Combat - Set Data 2 2 on Gurgthock (No Repeat)'),
(18398, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brokentoe - Out of Combat - Despawn Instant (No Repeat)'),
(18398, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Brokentoe - On Aggro - Say Line 0'),

(18399, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 2000, 2000, 0, 11, 14873, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - In Combat - Cast \'Sinister Strike\''),
(18399, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 11000, 12000, 0, 11, 15692, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - In Combat - Cast \'Eviscerate\''),
(18399, 0, 2, 0, 0, 0, 100, 0, 8000, 9000, 15000, 16000, 0, 11, 32319, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - In Combat - Cast \'Mutilate\''),
(18399, 0, 3, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - On Just Died - Add to Counter for Victory Event'),
(18399, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 39, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - On Aggro - Call For Help'),
(18399, 0, 5, 6, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - Out of Combat - Set Data 5 5 (No Repeat)'),
(18399, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 18399, 100, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - Out of Combat - Despawn Instant (No Repeat)'),
(18399, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - Out of Combat - Despawn Instant (No Repeat)'),
(18399, 0, 8, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 87, 1839900, 1839901, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - On Respawn - Run Random Script'),
-- (18399, 0, 8, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1839900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - On Data Set 1 1 - Run Left Script'),
-- (18399, 0, 9, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 80, 1839901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Twin - On Data Set 2 2 - Run Right Script'),

(18400, 0, 0, 0, 0, 0, 100, 0, 23000, 27000, 34000, 37000, 0, 11, 16727, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - In Combat - Cast \'War Stomp\''),
(18400, 0, 1, 0, 31, 0, 100, 0, 31389, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - On Target Spellhit \'Knock Away\' - Say Line 0'),
(18400, 0, 2, 0, 0, 0, 100, 0, 6000, 6000, 12000, 12000, 0, 11, 31389, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - In Combat - Cast \'Knock Away\''),
(18400, 0, 3, 0, 0, 0, 100, 0, 20000, 20000, 25000, 25000, 0, 11, 15976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - In Combat - Cast \'Puncture\''),
(18400, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 7, 7, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - On Just Died - Set Data 7 7'),
(18400, 0, 5, 6, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 45, 8, 8, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - Out of Combat - Set Data 8 8 (No Repeat)'),
(18400, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - Out of Combat - Despawn Instant (No Repeat)'),
(18400, 0, 7, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1840000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - On Data Set 1 1 - Run Script'),

(18401, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 29299, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Respawn - Cast \'Draining Touch\''),
(18401, 0, 1, 0, 0, 0, 100, 0, 6000, 9000, 24000, 27000, 0, 11, 16429, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - In Combat - Cast \'Piercing Shadow\''),
(18401, 0, 2, 8, 9, 0, 100, 0, 0, 5, 16000, 19000, 0, 11, 32324, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - Within 0-5 Range - Cast \'Shadow Burst\''),
(18401, 0, 3, 0, 0, 0, 100, 0, 12000, 15000, 33000, 37000, 0, 11, 32322, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - In Combat - Cast \'Dark Shriek\''),
(18401, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 10, 10, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Just Died - Set Data 10 10'),
(18401, 0, 5, 6, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 45, 11, 11, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Skra\'gath - Out of Combat - Set Data 11 11 (No Repeat)'),
(18401, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - Out of Combat - Despawn Instant (No Repeat)'),
(18401, 0, 7, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1840100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Data Set 1 1 - Run Script'),
(18401, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - After Shadow Burst - Wipe All Threat'),
(18401, 0, 9 , 10, 8, 1, 100, 0, 0, 2, 0, 0, 0, 11, 34336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Holy\' - Cast \'Damage Reduction: Holy\' (Phase 1)'),
(18401, 0, 10, 11, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Holy\' - Say Line 1 (Phase 1)'),
(18401, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Holy\' - Set Event Phase 0 (Phase 1)'),
(18401, 0, 12, 13, 8, 1, 100, 0, 0, 4, 0, 0, 0, 11, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Fire\' - Cast \'Damage Reduction: Fire\' (Phase 1)'),
(18401, 0, 13, 14, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Fire\' - Say Line 2 (Phase 1)'),
(18401, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Holy\' - Set Event Phase 0 (Phase 1)'),
(18401, 0, 15, 16, 8, 1, 100, 0, 0, 8, 0, 0, 0, 11, 34335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Nature\' - Cast \'Damage Reduction: Nature\' (Phase 1)'),
(18401, 0, 16, 17, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Nature\' - Say Line 3 (Phase 1)'),
(18401, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Holy\' - Set Event Phase 0 (Phase 1)'),
(18401, 0, 18, 19, 8, 1, 100, 0, 0, 16, 0, 0, 0, 11, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Frost\' - Cast \'Damage Reduction: Frost\' (Phase 1)'),
(18401, 0, 19, 20, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Frost\' - Say Line 4 (Phase 1)'),
(18401, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Holy\' - Set Event Phase 0 (Phase 1)'),
(18401, 0, 21, 22, 8, 1, 100, 0, 0, 32, 0, 0, 0, 11, 34338, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Shadow\' - Cast \'Damage Reduction: Shadow\' (Phase 1)'),
(18401, 0, 22, 23, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Shadow\' - Say Line 5 (Phase 1)'),
(18401, 0, 23, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Holy\' - Set Event Phase 0 (Phase 1)'),
(18401, 0, 24, 25, 8, 1, 100, 0, 0, 64, 0, 0, 0, 11, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Arcane\' - Cast \'Damage Reduction: Arcane\' (Phase 1)'),
(18401, 0, 25, 26, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Arcane\' - Say Line 6 (Phase 1)'),
(18401, 0, 26, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Spellhit \'Holy\' - Set Event Phase 0 (Phase 1)'),
(18401, 0, 27, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - On Aggro - Set Event Phase 1'),

(18402, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 31403, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - On Aggro - Cast \'Battle Shout\''),
(18402, 0, 1, 0, 9, 0, 100, 0, 8, 25, 23000, 25000, 0, 11, 32323, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - Within 8-25 Range - Cast \'Charge\''),
(18402, 0, 2, 0, 0, 0, 100, 0, 3000, 4000, 14000, 17000, 0, 11, 15708, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - In Combat - Cast \'Mortal Strike\''),
(18402, 0, 3, 0, 9, 0, 100, 0, 0, 5, 9000, 13000, 0, 11, 17963, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - Within 0-5 Range - Cast \'Sundering Cleave\''),
(18402, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 13, 13, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - On Just Died - Set Data 13 13'),
(18402, 0, 5, 6, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 45, 14, 14, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - Out of Combat - Set Data 14 14 (No Repeat)'),
(18402, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - Out of Combat - Despawn Instant (No Repeat)'),
(18402, 0, 7, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1840200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - On Data Set 1 1 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1839900, 1839901, 1840000, 1840100, 1840200));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1839900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Right Murkblood Twin - Actionlist - Play Emote 71'),
(1839900, 9, 1, 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Right Murkblood Twin - Actionlist - Start Attacking'),

(1839901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Left Murkblood Twin - Actionlist - Say Line 0'),
(1839901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Left Murkblood Twin - Actionlist - Start Attacking'),

(1840000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - Actionlist - Say Line 0'),
(1840000, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Rokdar the Sundered Lord - Actionlist - Start Attacking'),

(1840100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - Actionlist - Say Line 0'),
(1840100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Skra\'gath - Actionlist - Start Attacking'),

(1840200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - Actionlist - Say Line 0'),
(1840200, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Warmaul Champion - Actionlist - Start Attacking');

-- Adjustments to Mogor script
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18069);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18069, 0, 0, 0, 9, 0, 100, 0, 0, 30, 6000, 8000, 0, 11, 16033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Within 0-30 Range - Cast \'Chain Lightning\''),
(18069, 0, 1, 0, 9, 0, 100, 0, 0, 20, 8000, 18000, 0, 11, 39529, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Within 0-20 Range - Cast \'Flame Shock\''),
(18069, 0, 2, 0, 2, 0, 100, 0, 0, 50, 15000, 15000, 0, 11, 15982, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Between 0-50% Health - Cast \'Healing Wave\''),
(18069, 0, 3, 0, 0, 0, 100, 0, 3400, 6400, 13200, 26400, 0, 11, 18975, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - In Combat - Cast \'Summon Ice Totem\''),
(18069, 0, 5, 0, 2, 0, 100, 1, 0, 1, 1200, 1200, 0, 80, 1806902, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Between 0-1% Health - Run Script (No Repeat)'),
(18069, 0, 4, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1806900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - On Data Set 1 1 - Run Script'),
-- (18069, 0, 6, 7, 1, 0, 100, 0, 45000, 45000, 45000, 45000, 0, 45, 17, 17, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Mogor - Out of Combat - Set Data 17 17 - Failure Event'), -- Does not work. Event seems to be queued until the condition (near Gurgthock) is passed
-- (18069, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Out of Combat - Despawn Instant - Failure Event'),
(18069, 0, 6, 7, 7, 0, 100, 0, 0, 0, 0, 0, 0, 45, 17, 17, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Mogor - On Evade - Set Data 17 17 - Failure Event'), -- This is where I gave up. Should be a timer but it did not work with OOC timers or event phases in cases of reset
(18069, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - On Evade - Despawn Instant - Failure Event'),
(18069, 0, 8, 9, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 16, 16, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Mogor - On Just Died - Set Data 16 16 - Success Event'),
(18069, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - On Just Died - Despawn In 5000 ms'),
(18069, 0, 10, 0, 58, 0, 100, 0, 17, 1806900, 0, 0, 0, 80, 1806901, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - On Waypoint Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1806900, 1806901, 1806902));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1806900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Say Line 4'),
(1806900, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 53, 0, 1806900, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Start Waypoint'),

(1806901, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Set Orientation Stored Target'),
(1806901, 9, 1, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 1, 5, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Say Line 5'),
(1806901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Set Invincibility Hp 1'),
(1806901, 9, 3, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Set Faction 14'),
(1806901, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Set Event Phase 1'),
(1806901, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Set Reactstate Aggressive'),
(1806901, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Start Attacking Stored Target'),

(1806902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 12141, 50, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Despawn Instant'),
(1806902, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Missing comment for action_type 27'),
(1806902, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Remove All Auras'),
(1806902, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 31261, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Cast \'Permanent Feign Death (Root)\''),
(1806902, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 11, 32343, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Cast \'Revive Self\''),
(1806902, 9, 5, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Remove All Auras'),
(1806902, 9, 6, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 11, 28747, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Cast \'Frenzy\''),
(1806902, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Start Attacking'),
(1806902, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 6, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Say Line 6'),
(1806902, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - Actionlist - Reset Invincibility Hp');

DELETE FROM `waypoints` WHERE `entry`=18069; -- Delete old one
DELETE FROM `waypoints` WHERE `entry`=1806900 AND `point_comment`='Mogor';
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(1806900,1 ,-714.55914,7927.985,58.98062,NULL,'Mogor'),
(1806900,2 ,-715.80914,7925.235,59.23062,NULL,'Mogor'),
(1806900,3 ,-716.05914,7924.235,59.48062,NULL,'Mogor'),
(1806900,4 ,-717.30914,7920.735,58.98062,NULL,'Mogor'),
(1806900,5 ,-718.05914,7918.985,58.23062,NULL,'Mogor'),
(1806900,6 ,-718.80914,7916.985,57.98062,NULL,'Mogor'),
(1806900,7 ,-719.30914,7916.235,57.23062,NULL,'Mogor'),
(1806900,8 ,-719.55914,7915.235,56.48062,NULL,'Mogor'),
(1806900,9 ,-720.21796,7914.135,55.32333,NULL,'Mogor'),
(1806900,10,-720.4691,7905.346,50.524868,NULL,'Mogor'),
(1806900,11,-720.1519,7905.2637,50.770866,NULL,'Mogor'),
(1806900,12,-719.6519,7904.5137,50.520866,NULL,'Mogor'),
(1806900,13,-719.4019,7903.5137,50.020866,NULL,'Mogor'),
(1806900,14,-718.4019,7902.0137,49.770866,NULL,'Mogor'),
(1806900,15,-717.6519,7900.2637,49.520866,NULL,'Mogor'),
(1806900,16,-716.9019,7898.5137,49.270866,NULL,'Mogor'),
(1806900,17,-715.9375,7896.4297,48.333324,NULL,'Mogor');

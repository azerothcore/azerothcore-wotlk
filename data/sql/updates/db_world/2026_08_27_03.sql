-- DB update 2026_08_27_02 -> 2026_08_27_03
--
/*
22:13:41.323
Spawn
22:13:46.515
Anselm Move
X: 1857.6774 Y: -6150.2666 Z: 23.35034
22:13:48.591
Spawn Crossbowmen
22:13:49.565
Text: Archers at the ready!  Hold your fire!
22:13:57.650
Text: What fool dares to enter her majesty's dominion unannounced?
22:14:07.340
Text: Ah, but it is you who intrudes on our master's territory.  He could wipe you out in an instant for that transgression alone!  Arthas does not have much love or patience for his escaped slaves. (11)
22:14:17.760
Text: But... he has learned of your victory over Stormwind's North Fleet and thinks you have potential.  Potential to see reason and abandon Sylvanas' childish rebellion. (1)
22:14:29.204
Text: Arthas is prepared to offer you power beyond your imagination.  The puny army you lead here would pale in comparison to the phalanxes at your command if you returned to the Scourge's embrace.
22:14:42.183
Text: Behold the Vrykul!   A race that has perfected war and destruction to the point of an art form.  Already they've cast their lot with the Lich King!  Their dwellings surround you and their numbers are easily five times yours.
22:14:56.756
Text: The choice is yours, Anselm.  Return to the Lich King's army and fight alongside them or remain loyal to your so-called queen and suffer their wrath as they drive you * their homelands!
22:15:02.834
Text: Is that all you've come to say?
22:15:12.129
Text: Send these scumbags back to hell!  Fire at will!
22:15:12.332
(Cast) SpellID: 42905 (42905) Entry: 23883
22:15:14.444
Keleseth (Cast) SpellID: 43066 (43066)
22:15:14.566
Text: Such a futile gesture.
22:15:17.646
Keleseth (Cast) SpellID: 42982 (42982) at Generic Trigger LAB (24042)
22:15:20.933
Keleseth
Start Path 2
22:15:21.771
Winterskorn Warriors (Cast) SpellID: 45254 (45254)
22:15:25.784
Keleseth (Cast) SpellID: 43056 (43056)
On Hit Crossbowman: Cast 45254 on Self
22:15:25.914
Text: Listen to your men's dying breaths as I drink in their souls!
22:15:33.844
Text: This will not be the last you hear of me.  I will return to spit on your corpse after Utgarde's armies have descended upon you! (25)
22:15:37.143
(Destroyed) Winterskorn Warriors
22:15:44.016
(Destroyed) Keleseth
*/
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 23780 AND `summonerType` = 0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(23780, 0, 0, 24041, 1872.4625, -6088.7383, 16.20698, 3.81407928466796875, 8, 0, 'High Executor Anselm - Prince Keleseth'),
(23780, 0, 0, 24044, 1874.4657, -6086.84, 16.188915, 4.502949237823486328, 6, 15000, 'High Executor Anselm - Winterskorn Guard for Keleseth Event'),
(23780, 0, 0, 24044, 1869.6465, -6086.0728, 15.540292, 4.572762489318847656, 6, 15000, 'High Executor Anselm - Winterskorn Guard for Keleseth Event'),
(23780, 0, 0, 24044, 1874.8529, -6082.1724, 15.521532, 4.502949237823486328, 6, 15000, 'High Executor Anselm - Winterskorn Guard for Keleseth Event'),
(23780, 0, 0, 24044, 1869.9729, -6082.041, 15.131607, 4.572762489318847656, 6, 15000, 'High Executor Anselm - Winterskorn Guard for Keleseth Event'),

(23780, 0, 1, 23883, 1860.3945, -6158.918, 23.703222, 1.48352980613708496 , 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event'),
(23780, 0, 1, 23883, 1861.8228, -6159.0996, 23.71347, 1.518436431884765625, 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event'),
(23780, 0, 1, 23883, 1863.592, -6159.3833, 23.735474, 1.570796370506286621, 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event'),
(23780, 0, 1, 23883, 1865.4386, -6159.7563, 23.765726, 1.588249564170837402, 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event'),
(23780, 0, 1, 23883, 1867.8698, -6161.885, 23.78007, 1.640609502792358398 , 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event'),
(23780, 0, 1, 23883, 1865.9646, -6161.6113, 23.773127, 1.605702877044677734, 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event'),
(23780, 0, 1, 23883, 1867.106, -6160.068, 23.773989, 1.640609502792358398 , 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event'),
(23780, 0, 1, 23883, 1860.7349, -6160.7017, 23.731232, 1.500983119010925292, 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event'),
(23780, 0, 1, 23883, 1862.2368, -6161.0356, 23.74415, 1.535889744758605957, 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event'),
(23780, 0, 1, 23883, 1864.2344, -6161.2446, 23.766222, 1.570796370506286621, 6, 15000, 'High Executor Anselm - Forsaken Crossbowman for Keleseth Event');

-- Keleseth Paths
DELETE FROM `waypoints` WHERE `entry` = 24041;
DELETE FROM `waypoint_data` WHERE `id` IN (240411, 240412);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(240411, 1, 1868.8761, -6103.927, 18.09756, NULL),
(240411, 2, 1867.4551, -6115.4375, 20.250027, NULL),
(240411, 3, 1865.9219, -6123.009, 22.36716, NULL),
(240411, 4, 1864.4626, -6135.706, 23.22949, NULL),

(240412, 1, 1863.2947, -6133.7344, 23.334227, NULL),
(240412, 2, 1862.9902, -6136.032, 23.334227, NULL);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23780);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23780, 0, 0, 0, 20, 0, 100, 0, 11234, 0, 0, 0, 0, 0, 80, 2378000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - On Quest \'Report to Anselm\' Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2378000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2378000, 9, 0 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Summon Creature Group 0'),
(2378000, 9, 1 , 0, 0, 0, 100, 0, 5200, 5200, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Set Run Off'),
(2378000, 9, 2 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1857.6774, -6150.2666, 23.35034, 0, 'High Executor Anselm - Actionlist - Move To Position'),
(2378000, 9, 3 , 0, 0, 0, 100, 0, 2075, 2075, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Summon Creature Group 1'),
(2378000, 9, 4 , 0, 0, 0, 100, 0, 975, 975, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Say Line 0'),
(2378000, 9, 5 , 0, 0, 0, 100, 0, 8085, 8085, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Say Line 1'),
(2378000, 9, 6 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Set Orientation \'Prince Keleseth\''),
(2378000, 9, 7 , 0, 0, 0, 100, 0, 9690, 9690, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Say Line 0'),
(2378000, 9, 8 , 0, 0, 0, 100, 0, 10420, 10420, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Say Line 1'),
(2378000, 9, 9 , 0, 0, 0, 100, 0, 11444, 11444, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Say Line 2'),
(2378000, 9, 10, 0, 0, 0, 100, 0, 12980, 12980, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Say Line 3'),
(2378000, 9, 11, 0, 0, 0, 100, 0, 14570, 14570, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Say Line 4'),
(2378000, 9, 12, 0, 0, 0, 100, 0, 6080, 6080, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Say Line 2'),
(2378000, 9, 13, 0, 0, 0, 100, 0, 9300, 9300, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Say Line 3'),
(2378000, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 375, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Set Emote State 375'),
(2378000, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Set Keleseth Sheathe State'),
(2378000, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 375, 0, 0, 0, 0, 0, 9, 24044, 0, 50, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Set Emote State 375'),
(2378000, 9, 17, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 86, 42905, 0, 204, 23883, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Cross Cast \'Time-Warped Shoot\''),
(2378000, 9, 18, 0, 0, 0, 100, 0, 2100, 2100, 0, 0, 0, 0, 86, 43066, 0, 19, 24041, 40, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Cross Cast \'Cone of Cold\''),
(2378000, 9, 19, 0, 0, 0, 100, 0, 120, 120, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Say Line 5'),
(2378000, 9, 20, 0, 0, 0, 100, 0, 3080, 3080, 0, 0, 0, 0, 86, 42982, 0, 19, 24041, 40, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Cross Cast \'Vampire Prince Teleport\''),
(2378000, 9, 21, 0, 0, 0, 100, 0, 3280, 3280, 0, 0, 0, 0, 232, 240412, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Start Path 240412'),
(2378000, 9, 22, 0, 0, 0, 100, 0, 4850, 4850, 0, 0, 0, 0, 86, 43056, 0, 19, 24041, 40, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Cross Cast \'Vampire Soul Retrieve Channel\''),
(2378000, 9, 23, 0, 0, 0, 100, 0, 130, 130, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Say Line 6'),
(2378000, 9, 24, 0, 0, 0, 100, 0, 7930, 7930, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Say Line 7'),
(2378000, 9, 25, 0, 0, 0, 100, 0, 6870, 6870, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 24041, 40, 0, 0, 0, 0, 0, 0, 'High Executor Anselm - Actionlist - Keseleth Despawn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24041);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24041, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 240411, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Keleseth - On Just Summoned - Start Path 240411'),
(24041, 0, 1, 0, 60, 0, 100, 1, 200, 200, 0, 0, 0, 0, 230, 1, 2, 300, 0, 0, 0, 9, 24044, 0, 40, 1, 0, 0, 0, 0, 'Prince Keleseth - On Update - Follow Type Semi-Circle Behind (No Repeat)'),
(24041, 0, 2, 0, 109, 0, 100, 1, 0, 240411, 0, 0, 0, 0, 230, 0, 0, 0, 0, 0, 0, 9, 24044, 0, 40, 1, 0, 0, 0, 0, 'Prince Keleseth - On Path 240411 Finished - Stop Follow');

UPDATE `conditions` SET `ConditionValue2` = 24042, `Comment` = 'Vampire Prince Teleport targets Generic Trigger LAB' WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 42982) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 23883) AND (`ConditionValue3` = 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23883);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23883, 0, 0, 0, 8, 0, 100, 0, 43056, 0, 0, 0, 0, 0, 11, 45254, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Crossbowman - On Spellhit \'Vampire Soul Retrieve Channel\' - Cast \'Suicide\'');

DELETE FROM `creature_template_addon` WHERE (`entry` = 23883);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(23883, 0, 0, 0, 2, 0, 0, '');

UPDATE `creature_template` SET `unit_flags` = 768 WHERE (`entry` = 24041);
UPDATE `creature_template` SET `unit_flags` = 33024 WHERE (`entry` = 24044);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24044;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24044);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24044, 0, 0, 0, 8, 0, 100, 0, 42905, 0, 0, 0, 0, 0, 11, 45254, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Winterskorn Guard - On Spellhit \'Time-Warped Shoot\' - Cast \'Suicide\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2404400, 2404401, 2404402, 2404403));
DELETE FROM `waypoints` WHERE `entry` IN (2404400, 2404401, 2404402, 2404403);

-- Add Emotes
DELETE FROM `creature_text` WHERE (`CreatureID` = 24041) AND (`GroupID` IN (0, 1, 7));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24041, 0, 0, 'Ah, but it is you who intrudes on our master\'s territory.  He could wipe you out in an instant for that transgression alone!  Arthas does not have much love or patience for his escaped slaves.', 12, 0, 100, 11, 0, 0, 22665, 0, 'Prince Keleseth'),
(24041, 1, 0, 'But... he has learned of your victory over Stormwind\'s North Fleet and thinks you have potential.  Potential to see reason and abandon Sylvanas\' childish rebellion.', 12, 0, 100, 1, 0, 0, 22669, 0, 'Prince Keleseth'),
(24041, 7, 0, 'This will not be the last you hear of me.  I will return to spit on your corpse after Utgarde\'s armies have descended upon you!', 12, 0, 100, 25, 0, 0, 22764, 0, 'Prince Keleseth');

DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 24041);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(24041, 1, 27769, 0, 0, 49822);

DELETE FROM `creature_template_addon` WHERE (`entry` = 24041);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(24041, 0, 0, 0, 0, 0, 0, '');

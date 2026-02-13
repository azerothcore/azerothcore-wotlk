-- DB update 2026_02_12_00 -> 2026_02_12_01
--
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 25301);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(25301, 1, 23240, 0, 0, 62044);

DELETE FROM `creature_text` WHERE (`CreatureID` = 25301);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25301, 0, 0, 'Our troops, general, consist mostly of villagers and peasants.  Good men, but not quite rid of the prejudices and superstitions of their upbringing.  They\'re not ready to fight alongside our more exotic allies.', 12, 7, 100, 1, 0, 0, 24789, 0, 'Counselor Talbot'),
(25301, 1, 0, 'My liege, the infiltration and control of the Alliance power structure by our cultists is well underway.', 12, 0, 100, 0, 0, 14211, 25357, 0, 'Talbot - Last Rites'),
(25301, 2, 0, 'The power you\'ve bestowed upon me has granted me great mental influence over human minds.  I bear these offerings as proof of my progress.', 12, 0, 100, 0, 0, 14212, 25358, 0, 'Talbot - Last Rites'),
(25301, 3, 0, 'Allow me to take care of the intruders, lord.  I will feed their entrails to the maggots.', 12, 0, 100, 1, 0, 14213, 25361, 0, 'Talbot - Last Rites'),
(25301, 4, 0, 'Yes, my lord!', 12, 0, 100, 1, 0, 14214, 25365, 0, 'Talbot - Last Rites');

-- Duplicated to not create issues after UpdateEntry
DELETE FROM `creature_text` WHERE (`CreatureID` = 28189);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28189, 0, 0, 'Our troops, general, consist mostly of villagers and peasants.  Good men, but not quite rid of the prejudices and superstitions of their upbringing.  They\'re not ready to fight alongside our more exotic allies.', 12, 7, 100, 1, 0, 0, 24789, 0, 'Prince Valanar'),
(28189, 1, 0, 'My liege, the infiltration and control of the Alliance power structure by our cultists is well underway.', 12, 0, 100, 0, 0, 14211, 25357, 0, 'Prince Valanar - Last Rites'),
(28189, 2, 0, 'The power you\'ve bestowed upon me has granted me great mental influence over human minds.  I bear these offerings as proof of my progress.', 12, 0, 100, 0, 0, 14212, 25358, 0, 'Prince Valanar - Last Rites'),
(28189, 3, 0, 'Allow me to take care of the intruders, lord.  I will feed their entrails to the maggots.', 12, 0, 100, 1, 0, 14213, 25361, 0, 'Prince Valanar - Last Rites'),
(28189, 4, 0, 'Yes, my lord!', 12, 0, 100, 1, 0, 14214, 25365, 0, 'Prince Valanar - Last Rites');

DELETE FROM `creature_text` WHERE (`CreatureID` = 26203);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26203, 0, 0, 'Your progress in this region has been impressive, blood prince.  I am pleased.', 12, 0, 100, 0, 0, 14756, 25362, 0, 'thassarian SAY_LICH_1'),
(26203, 1, 0, 'Now this is a surprise, Thassarian.  I hadn\'t heard from Mograine or the other death knights for months.  You\'ve come to rejoin the Scourge, I take it?', 12, 0, 100, 0, 0, 14757, 25363, 0, 'thassarian SAY_LICH_2'),
(26203, 2, 0, 'Do not fail me, San\'layn.  Return to Icecrown with this fool\'s head or do not bother to return.', 12, 0, 100, 1, 0, 14758, 25364, 0, 'thassarian SAY_LICH_3');

DELETE FROM `creature_text` WHERE (`CreatureID` = 26170) AND (`GroupID` IN (2));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26170, 2, 0, 'I would sooner slit my own throat.  You will pay for what you did to your own men, Arthas... for what you did to me!  I swear it.', 12, 0, 100, 53, 0, 14666, 25366, 0, 'thassarian SAY_THASSARIAN_3');

UPDATE `creature` SET `ScriptName` = '' WHERE `guid` IN (101136, 101303) AND `id1` = 26170;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26170;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26170);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26170, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 0, 11, 50995, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Update - Cast \'Empowered Blood Presence\''),
(26170, 0, 1, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 0, 11, 52374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - In Combat - Cast \'Blood Strike\''),
(26170, 0, 2, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 0, 11, 52372, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - In Combat - Cast \'Icy Touch\''),
(26170, 0, 3, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 0, 11, 50668, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - In Combat - Cast \'Death Coil\'');

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` = 26170);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -101136);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-101136, 0, 1000, 0, 1, 0, 100, 0, 1000, 1000, 3600, 3600, 0, 0, 11, 46685, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Out of Combat - Cast \'Borean Tundra - Quest - Thassarian Flay\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -101303);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-101303, 0, 1000, 0, 62, 0, 100, 0, 9417, 0, 0, 0, 0, 0, 80, 2617001, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Gossip Option Selected - Run Script: Initiate Quest Last Rites'),
(-101303, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2617000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Respawn - Run Cleanup Script'),
(-101303, 0, 1002, 0, 109, 0, 100, 0, 0, 261701, 0, 0, 0, 0, 80, 2617002, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Path Finished - Run Script: Last Rites RP Part 1'),
(-101303, 0, 1003, 0, 77, 0, 100, 0, 1, 2, 0, 0, 0, 0, 80, 2617003, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Lich King and Talbot Finished Pathing - Run Script: Last Rites RP  Part 2'),
(-101303, 0, 1004, 0, 77, 0, 100, 0, 1, 4, 0, 0, 0, 0, 80, 2617004, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Leryssa and Arlos Finished Pathing - Run Script: Last Rites RP Part 3'),
(-101303, 0, 1005, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2617005, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Reached Point - Run Script: Last Rites RP Part 4'),
(-101303, 0, 1006, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Just Died - Despawn Instant'),
(-101303, 0, 1007, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Just Died - Despawn Instant'),
(-101303, 0, 1008, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Action Received - Increment Counter'),
(-101303, 0, 1009, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 2617006, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Event Received from Leryssa - Run Cleanup Script'),
(-101303, 0, 1010, 0, 17, 0, 100, 0, 25301, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Summoned Unit - Store Talbot'),
(-101303, 0, 1011, 0, 17, 0, 100, 0, 26203, 0, 0, 0, 0, 0, 64, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Summoned Unit - Store Lich King');

-- Respawn
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2617000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2617000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Reset Counter'),
(2617000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Despawn Instant'),
(2617000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1974, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Faction 1974'),
(2617000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Remove StandState Kneel'),
(2617000, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Reset EmoteState'),
(2617000, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Remove Npc Flags Questgiver'),
(2617000, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Add Npc Flags Gossip'),
(2617000, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Active Off');
-- Gossip Option Selected
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2617001);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2617001, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Store Player Party'),
(2617001, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Active On'),
(2617001, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Reset Counter'),
(2617001, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Remove Npc Flags Gossip'),
(2617001, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 261701, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Start Path 261701');
-- First Path Finished
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2617002);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2617002, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Emote State 333'),
(2617002, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Summon Creature Group 0: Talbot and Lich King');
-- On Talbot and Image of the Lich King Finished their paths (Counter 2)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2617003);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2617003, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 2, 974, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Faction 974'),
(2617003, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 36, 28189, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Update Template To \'Prince Valanar\''),
(2617003, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Load Equipment Id 1'),
(2617003, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2617003, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Lich King Say Line 0'),
(2617003, 9, 5, 0, 0, 0, 100, 0, 8200, 8200, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Talbot Say Line 1'),
(2617003, 9, 6, 0, 0, 0, 100, 0, 8600, 8600, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Summon Creature Group 1: Arlos and Leryssa'),
(2617003, 9, 7, 0, 0, 0, 100, 0, 5500, 5500, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Talbot Say Line 2');
-- On Arlos and Leryssa finished their paths (Counter 4)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2617004);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2617004, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Say Line 0'),
(2617004, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3722.5269, 3567.258, 477.57098, 0, 'Thassarian - Actionlist - Move To Position');
-- On Reached Pos
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2617005);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2617005, 9, 0 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Say Line 1'),
(2617005, 9, 1 , 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 231, 2, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Lich King Orientation'),
(2617005, 9, 2 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Talbot Set Flag Standstate Stand Up'),
(2617005, 9, 3 , 0, 0, 0, 100, 0, 4200, 4200, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Lich King Say Line 1'),
(2617005, 9, 4 , 0, 0, 0, 100, 0, 17800, 17800, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Say Line 2'),
(2617005, 9, 5 , 0, 0, 0, 100, 0, 9600, 9600, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Talbot Say Line 3'),
(2617005, 9, 6 , 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 231, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 1.4356470108032227, 'Thassarian - Actionlist - Set Lich King Orientation'),
(2617005, 9, 7 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Lich King Say Line 2'),
(2617005, 9, 8 , 0, 0, 0, 100, 0, 4400, 4400, 0, 0, 0, 0, 231, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 3.006659984588623, 'Thassarian - Actionlist - Set Lich King Orientation'),
(2617005, 9, 9 , 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Lich King Play Emote 25'),
(2617005, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 4800, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Lich King Despawn In 4800 ms'),
(2617005, 9, 11, 0, 0, 0, 100, 0, 6600, 6600, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Talbot Say Line 4'),
(2617005, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1988, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Talbot Set Faction 1988'),
(2617005, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Talbot Remove Flags Immune To Players & Immune To NPC\'s'),
(2617005, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 86, 9613, 2, 12, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Talbot Cross Cast \'Shadow Bolt\''),
(2617005, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Home Position');
-- Talbot Dead -> Leryssa takes over
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2525101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2525101, 9, 0, 0, 0, 0, 100, 0, 5200, 5200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Say Line 0'),
(2525101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Reset Emote State'),
(2525101, 9, 2, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3726.4373, 3568.1, 477.54553, 0, 'Leryssa - Actionlist - Move To Thassarian'),
(2525101, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 26170, 50, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Thassarian Say Line 3'),
(2525101, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 19, 26170, 50, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Set Thassarian Standstate Kneel'),
(2525101, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 19, 26170, 50, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Set Thassarian as Questgiver');
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2525102);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2525102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Set Flag Standstate Sit Down'),
(2525102, 9, 1, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Say Line 1'),
(2525102, 9, 2, 0, 0, 0, 100, 0, 7200, 7200, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 26170, 20, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Thassarian Say Line 4'),
(2525102, 9, 3, 0, 0, 0, 100, 0, 6900, 6900, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Say Line 2'),
(2525102, 9, 4, 0, 0, 0, 100, 0, 14200, 14200, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 26170, 20, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Thassarian Say Line 5'),
(2525102, 9, 5, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Say Line 3'),
(2525102, 9, 6, 0, 0, 0, 100, 0, 14200, 14200, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 26170, 20, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Thassarian Say Line 6'),
(2525102, 9, 7, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 19, 26170, 20, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Send Action to Thassarian, Cleanup Quest Event');
-- Despawn All
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2617006);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2617006, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Despawn Instant'),
(2617006, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Despawn Instant');

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 26170 AND `summonerType` = 0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(26170, 0, 0, 25301, 3748.7627, 3614.0374, 473.4048, 4.55531, 6, 30000, 'Last Rites - Counselor Talbot (25301)'),
(26170, 0, 0, 26203, 3729.4614, 3520.386, 473.4048, 1.362439, 6, 30000, 'Last Rites - Image of the Lich King (26203)'),

(26170, 0, 1, 25251, 3750.8022, 3611.4067, 473.4192, 4.62829, 6, 30000, 'Last Rites - Leryssa (25251)'),
(26170, 0, 1, 25250, 3745.2783, 3613.004, 473.42523, 4.42246, 6, 30000, 'Last Rites - General Arlos (25250)');

DELETE FROM `waypoint_data` WHERE `id` IN (261701, 253011, 262031, 252511, 252501);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES
-- Thassarian
(261701, 1, 3695.3281, 3576.184, 473.95667, NULL, 0),
(261701, 2, 3701.8281, 3574.434, 473.95667, NULL, 0),
(261701, 3, 3708.717, 3572.3823, 477.50854, NULL, 0),
(261701, 4, 3713.3604, 3570.719, 477.5991 , NULL, 0),
-- Talbot
(253011, 1, 3746.9602, 3607.5066, 473.43402, NULL, 0),
(253011, 2, 3745.358, 3600.3086, 477.3036  , NULL, 0),
(253011, 3, 3742.5251, 3586.4634, 477.68497, NULL, 0),
(253011, 4, 3738.2366, 3570.346, 477.63406 , NULL, 0),
-- Lich King
(262031, 1, 3732.6357, 3535.3997, 477.41446, NULL, 0),
(262031, 2, 3733.244, 3538.2766, 477.50858 , NULL, 0),
(262031, 3, 3736.5, 3556.1492, 477.63403   , NULL, 0),
(262031, 4, 3737.5396, 3565.22, 477.63403  , NULL, 0),
-- Arlos
(252501, 1, 3744.8464, 3611.5564, 473.42465, NULL, 0),
(252501, 2, 3742.4666, 3598.8833, 477.52597, NULL, 0),
(252501, 3, 3739.2288, 3587.0754, 477.62778, NULL, 0),
(252501, 4, 3735.5715, 3572.422, 477.62778 , NULL, 0),
-- Leryssa
(252511, 1, 3750.0989, 3603.0605, 474.33777, NULL, 0),
(252511, 2, 3747.6184, 3591.2925, 477.62778, NULL, 0),
(252511, 3, 3741.9653, 3571.4446, 477.62778, NULL, 0),
(252511, 4, 3741.9653, 3571.4446, 477.62778, 4.537856101989746093, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 25301);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25301);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25301, 0, 0, 0, 0, 0, 100, 0, 0, 500, 3000, 3500, 0, 0, 11, 51016, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - In Combat - Cast \'Vampiric Bolt\''),
(25301, 0, 1, 0, 0, 0, 100, 0, 15000, 43000, 45000, 73000, 0, 0, 11, 50992, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - In Combat - Cast \'Soul Blast\''),
(25301, 0, 2, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 0, 0, 11, 51009, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - In Combat - Cast \'Soul Deflection\''),
(25301, 0, 3, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 253011, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Just Summoned - Start Path'),
(25301, 0, 4, 0, 109, 0, 100, 0, 0, 253011, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Path Finished - Send Action to Thassarian'),
(25301, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 25250, 100, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Just Died - Send Event to General Arlos'),
(25301, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 25251, 100, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Just Died - Send Event to Leryssa'),
(25301, 0, 7, 0, 109, 0, 100, 0, 0, 253011, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Path Finished - Set Flag Standstate Kneel'),
(25301, 0, 8, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Respawn - Deload Equipment');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26203;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26203);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26203, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 262031, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of the Lich King - On Just Summoned - Start Path'),
(26203, 0, 1, 0, 109, 0, 100, 0, 0, 262031, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Image of the Lich King - On Path Finished - Send Action to Thassarian');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25250;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25250);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25250, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2525000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - On Just Summoned - Run Script'),
(25250, 0, 1, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2525001, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - On Action 1 Done - Run Script'),
(25250, 0, 2, 0, 109, 0, 100, 0, 0, 252501, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'General Arlos - On Path Finished - Send Event to Thassarian');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2525000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2525000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2525000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 64, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Set Emote State 64'),
(2525000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 252501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Start Path');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2525001);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2525001, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Say Line 0'),
(2525001, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Play Emote 0'),
(2525001, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Set Flag Standstate Kneel'),
(2525001, 9, 3, 0, 0, 0, 100, 0, 3800, 3800, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Set Flag Standstate Kneel'),
(2525001, 9, 4, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Set Flag Standstate Dead'),
(2525001, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Say Line 1'),
(2525001, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Actionlist - Despawn In 40000 ms');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 25251);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25251);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25251, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2525100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - On Just Summoned - Run Script'),
(25251, 0, 1, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2525101, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - On Talbot Died - Run Script'),
(25251, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2525102, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - On Reached Thassarian - Run Script'),
(25251, 0, 3, 0, 109, 0, 100, 0, 0, 252511, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Leryssa - On Path Finished - Send Event to Thassarian');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2525100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2525100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2525100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 64, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Set Emote State 64'),
(2525100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 252511, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Start Path');

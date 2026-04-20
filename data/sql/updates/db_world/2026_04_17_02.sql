-- DB update 2026_04_17_01 -> 2026_04_17_02

-- Clean useless Trigger GUID SAI and Comment
UPDATE `creature` SET `Comment` = '' WHERE (`id1` = 23837) AND (`guid` IN (98562));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -98562) AND (`source_type` = 0);

-- Set Heb'Jin's Drum SAI
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 190695;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 190695);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(190695, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - On Gameobject State Changed - Store Targetlist'),
(190695, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 19069500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - On Gameobject State Changed - Run Script');

-- Set Heb'Jin's Drum Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 19069500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19069500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 28636, 6, 30000, 0, 0, 0, 8, 0, 0, 0, 0, 5988.71, -3878.04, 417.15, 2.35619, 'Heb\'Jin\'s Drum - Actionlist - Summon Creature \'Heb\'Jin\''),
(19069500, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 11, 28636, 300, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - Actionlist - Send Target 1'),
(19069500, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 223, 40, 0, 0, 0, 0, 0, 204, 28636, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Drum - Actionlist - Do Action ID 40');

-- Set Heb'Jin SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28636;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28636);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28636, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2863600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - On Just Summoned - Run Script'),
(28636, 0, 1, 0, 72, 0, 100, 0, 41, 0, 0, 0, 0, 0, 80, 2863601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - On Action 41 Done - Run Script'),
(28636, 0, 2, 0, 0, 0, 100, 0, 1000, 1000, 7000, 8000, 0, 0, 11, 12734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - In Combat - Cast \'Ground Smash\''),
(28636, 0, 3, 0, 0, 0, 100, 0, 5000, 5000, 10000, 12000, 0, 0, 11, 15548, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - In Combat - Cast \'Thunderclap\''),
(28636, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - On Evade - Despawn Instant');

-- Set Heb'Jin Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2863600, 2863601));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2863600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52353, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Cast \'Script Effect - Creature Capture GUID to Dot Variable\''),
(2863600, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 12, 28639, 6, 30000, 0, 0, 0, 8, 0, 0, 0, 0, 5984.55, -3882.62, 417.438, 1.91986, 'Heb\'Jin - Actionlist - Summon Creature \'Heb\'Jin\'s Bat\''),
(2863600, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 28639, 10, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Send Target 1'),
(2863600, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52154, 0, 0, 0, 0, 0, 19, 28639, 10, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Cast \'Taunt\''),
(2863600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 12009, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Play Sound 12009'),
(2863600, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Play Emote 5'),
(2863600, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Say Line 0'),
(2863600, 9, 7, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Play Emote 15'),
(2863600, 9, 8, 0, 0, 0, 100, 0, 150, 150, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Say Line 1'),
(2863600, 9, 9, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 11, 43671, 0, 0, 0, 0, 0, 19, 28639, 10, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Cast \'Ride Vehicle\''),
(2863601, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Set Home Position'),
(2863601, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Remove Flags Immune To Players'),
(2863601, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Start Attacking'),
(2863601, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin - Actionlist - Say Line 2');

-- Set Heb'Jin's Bat SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28639;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28639);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28639, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Respawn - Remove FlagStandstate Dead'),
(28639, 0, 1, 0, 8, 0, 100, 0, 52154, 0, 0, 0, 0, 0, 11, 52353, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Spellhit \'Taunt\' - Cast \'Script Effect - Creature Capture GUID to Dot Variable\''),
(28639, 0, 2, 0, 27, 0, 100, 1, 0, 0, 0, 0, 0, 0, 53, 2, 28639, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Passenger Boarded - Start Waypoint Path 28639 (No Repeat)'),
(28639, 0, 3, 4, 40, 0, 100, 0, 4, 28639, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Point 4 of Path 28639 Reached - Set Home Position'),
(28639, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 43671, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Point 4 of Path 28639 Reached - Remove Aura \'Ride Vehicle\''),
(28639, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 41, 0, 0, 0, 0, 0, 19, 28636, 10, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Point 4 of Path 28639 Reached - Do Action ID 41'),
(28639, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2863900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Point 4 of Path 28639 Reached - Run Script'),
(28639, 0, 7, 8, 8, 0, 100, 0, 52151, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Spellhit \'Bat Net\' - Set Flags Immune To Players'),
(28639, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Spellhit \'Bat Net\' - Set Flag Standstate Dead'),
(28639, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Spellhit \'Bat Net\' - Despawn In 5000 ms'),
(28639, 0, 10, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - On Evade - Despawn Instant');

-- Set Heb'Jin's Bat Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2863900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2863900, 9, 0, 0, 0, 0, 100, 0, 3000, 4000, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - Actionlist - Remove Flags Immune To Players'),
(2863900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - Actionlist - Set Reactstate Aggressive'),
(2863900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Jin\'s Bat - Actionlist - Start Attacking');

-- Update Old Conditions
UPDATE `conditions` SET `SourceEntry` = 190695, `SourceId` = 1 WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = -98562) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` IN (28636, 28639)) AND (`ConditionValue2` = 200) AND (`ConditionValue3` = 0);

-- Quest Bringing Down Heb'Jin needs Sealing the Rifts to be taken.
UPDATE `quest_template_addon` SET `PrevQuestID` = 12640 WHERE (`ID` = 12662);

-- Quest The Leaders at Jin'Alai needs To the Witch Doctor to be taken.
UPDATE `quest_template_addon` SET `PrevQuestID` = 12623 WHERE (`ID` = 12622);

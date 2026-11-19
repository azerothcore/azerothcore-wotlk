-- DB update 2026_10_17_01 -> 2026_10_17_02
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (19675, 20084);

DELETE FROM `creature_text` WHERE `CreatureID` IN (19675, 20084, 20163);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19675, 0, 0, 'That definitely ended our business relationship with Kael\'thas.  Please stay here.  I will return shortly and there is something that I want you to do.', 12, 0, 100, 1, 0, 0, 17797, 0, 'Nexus-Prince Haramad - Full Triangle'),
(20084, 0, 0, 'No, I think not.  The selflessness that I have just been witness to has cleared my mind.  My dealings with your master are at an end.  You may return and let him know that I have decided to turn the ata\'mal crystal over to the naaru.', 12, 0, 100, 1, 0, 0, 17793, 0, 'Image of Nexus-Prince Haramad - Full Triangle'),
(20084, 1, 0, 'Guards!  Hold on, I will be right there!', 12, 0, 100, 0, 0, 0, 17796, 0, 'Image of Nexus-Prince Haramad - Full Triangle'),
(20163, 0, 0, 'Indeed, Nexus-Prince Haramad, you do have much to think on.  Such as turning over that ata\'mal crystal to my master, Prince Kael\'thas.', 12, 0, 100, 1, 0, 0, 17787, 0, 'Ambassador Solannas - Full Triangle'),
(20163, 1, 0, 'WHAT!  This is outrageous!  You will pay for this Haramad!  You and your assistant here!', 12, 0, 100, 0, 0, 0, 17794, 0, 'Ambassador Solannas - Full Triangle');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (19675, 20084, 20163, 20199) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19675, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - On Just Summoned - Cast \'Ethereal Teleport\''),
(19675, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 4122.24, 2931.65, 354.51, 0, 'Nexus-Prince Haramad - On Just Summoned - Move To Position'),
(19675, 0, 2, 3, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - On Reached Point 1 - Set Home Position'),
(19675, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 123, 2, 0, 0, 0, 0, 0, 19, 20163, 60, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - On Reached Point 1 - Add Threat To Ambassador Solannas'),
(19675, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 123, 1, 0, 0, 0, 0, 0, 9, 20199, 0, 60, 1, 0, 0, 0, 0, 'Nexus-Prince Haramad - On Reached Point 1 - Add Threat To Ambassador\'s Honor Guard'),
(19675, 0, 5, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 1967500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - On Reached Point 1 - Run Script (no enemy left alive)'),
(19675, 0, 6, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1967500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - On Evade - Run Script'),
(20084, 0, 0, 0, 20, 0, 100, 0, 10276, 0, 0, 0, 0, 0, 80, 2008400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - On Quest \'Full Triangle\' Rewarded - Run Script'),
(20084, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 2008401, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - On Data Set 1 1 - Run Script'),
(20163, 0, 0, 0, 1, 0, 100, 513, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - Out of Combat - Disable Combat Movement (No Repeat)'),
(20163, 0, 1, 2, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - On Aggro - Cast \'Fireball\' (No Repeat)'),
(20163, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - On Aggro - Increment Phase By 1 (No Repeat)'),
(20163, 0, 3, 0, 9, 1, 100, 0, 0, 0, 3400, 4800, 0, 40, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - Within 0-40 Range - Cast \'Fireball\' (No Repeat)'),
(20163, 0, 4, 5, 3, 1, 100, 513, 0, 7, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - Between 0-7% Mana - Enable Combat Movement (Phase 1) (No Repeat)'),
(20163, 0, 5, 0, 61, 1, 100, 512, 0, 0, 0, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - Between 0-7% Mana - Increment Phase By 1 (Phase 1) (No Repeat)'),
(20163, 0, 6, 0, 9, 1, 100, 513, 0, 0, 0, 0, 35, 80, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - Within 35-80 Range - Enable Combat Movement (Phase 1) (No Repeat)'),
(20163, 0, 7, 0, 9, 1, 100, 513, 0, 0, 0, 0, 5, 15, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - Within 5-15 Range - Disable Combat Movement (Phase 1) (No Repeat)'),
(20163, 0, 8, 0, 9, 1, 100, 513, 0, 0, 0, 0, 0, 5, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - Within 0-5 Range - Enable Combat Movement (Phase 1) (No Repeat)'),
(20163, 0, 9, 0, 3, 2, 100, 512, 15, 100, 100, 100, 0, 0, 23, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - Between 15-100% Mana - Decrement Phase By 1 (Phase 1) (No Repeat)'),
(20163, 0, 10, 0, 106, 1, 100, 0, 9000, 15000, 9000, 15000, 0, 8, 11, 11831, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - Within 0-8 Range - Cast \'Frost Nova\' (Phase 1) (No Repeat)'),
(20163, 0, 11, 12, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - On Just Summoned - Cast \'Ethereal Teleport\''),
(20163, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - On Just Summoned - Set Run Off'),
(20163, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 4119.2725, 2932.0938, 354.5161, 0, 'Ambassador Solannas - On Just Summoned - Move To Position'),
(20163, 0, 14, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Solannas - On Data Set 1 1 - Attack Stored Target'),
(20199, 0, 0, 0, 9, 0, 100, 0, 0, 0, 8000, 12000, 0, 5, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador\'s Honor Guard - Within 0-5 Range - Cast \'Cleave\' (Phase 1) (No Repeat)'),
(20199, 0, 1, 2, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador\'s Honor Guard - On Just Summoned - Cast \'Ethereal Teleport\''),
(20199, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador\'s Honor Guard - On Just Summoned - Set Run Off'),
(20199, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0.59, -15.24, 0, 0, 'Ambassador\'s Honor Guard - On Just Summoned - Move Toward Image of Nexus-Prince Haramad'),
(20199, 0, 4, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ambassador\'s Honor Guard - On Data Set 1 1 - Attack Stored Target');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 19675 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 6, 19675, 0, 0, 29, 1, 20163, 60, 0, 1, 0, 0, '', 'Nexus-Prince Haramad - Leave at once if no living Ambassador Solannas is within 60 yards'),
(22, 6, 19675, 0, 0, 29, 1, 20199, 60, 0, 1, 0, 0, '', 'Nexus-Prince Haramad - Leave at once if no living Ambassador\'s Honor Guard is within 60 yards');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1967500, 2008400, 2008401) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1967500, 9, 0, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - Actionlist - Say Line 0'),
(1967500, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 4133.17, 2930.18, 354.545, 0, 'Nexus-Prince Haramad - Actionlist - Move To Position'),
(1967500, 9, 2, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - Actionlist - Cast \'Ethereal Teleport\''),
(1967500, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 14, 24926, 184071, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - Actionlist - Set GO State Active (Haramad\'s Holographic Stand)'),
(1967500, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 20084, 30, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - Actionlist - Set Data 1 1 on Image of Nexus-Prince Haramad'),
(1967500, 9, 5, 0, 0, 0, 100, 0, 1900, 1900, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Haramad - Actionlist - Despawn'),
(2008400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 20163, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Despawn Ambassador Solannas (previous turn-in)'),
(2008400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 20199, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Despawn Ambassador\'s Honor Guard (previous turn-in)'),
(2008400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Store Targetlist'),
(2008400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Active On'),
(2008400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Remove Npc Flags Gossip & Questgiver'),
(2008400, 9, 5, 0, 0, 0, 100, 0, 1800, 1800, 0, 0, 0, 0, 12, 20163, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 4118.53, 2947.36, 354.605, 4.76, 'Image of Nexus-Prince Haramad - Actionlist - Summon Creature \'Ambassador Solannas\''),
(2008400, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 20199, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 4119.93, 2949.94, 354.605, 4.6774, 'Image of Nexus-Prince Haramad - Actionlist - Summon Creature \'Ambassador\'s Honor Guard\''),
(2008400, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 20199, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 4117.2, 2949.8, 354.605, 4.69493, 'Image of Nexus-Prince Haramad - Actionlist - Summon Creature \'Ambassador\'s Honor Guard\''),
(2008400, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 204, 20163, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Flags Immune To Players & Immune To NPC\'s on Ambassador Solannas'),
(2008400, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 204, 20199, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Flags Immune To Players & Immune To NPC\'s on Ambassador\'s Honor Guard'),
(2008400, 9, 10, 0, 0, 0, 100, 0, 7500, 7500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 204, 20163, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Say Line 0 (Ambassador Solannas)'),
(2008400, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 204, 20163, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Orientation (Ambassador Solannas)'),
(2008400, 9, 12, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Say Line 0'),
(2008400, 9, 13, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Play Emote OneShotTalk'),
(2008400, 9, 14, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 204, 20163, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Play Emote OneShotExclamation (Ambassador Solannas)'),
(2008400, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 204, 20163, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Say Line 1 (Ambassador Solannas)'),
(2008400, 9, 16, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 204, 20163, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s on Ambassador Solannas'),
(2008400, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 204, 20199, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s on Ambassador\'s Honor Guard'),
(2008400, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 204, 20163, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Send Target List to Ambassador Solannas'),
(2008400, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 204, 20199, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Send Target List to Ambassador\'s Honor Guard'),
(2008400, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 204, 20163, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Data 1 1 on Ambassador Solannas'),
(2008400, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 204, 20199, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Data 1 1 on Ambassador\'s Honor Guard'),
(2008400, 9, 22, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Play Emote OneShotRoar'),
(2008400, 9, 23, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Say Line 1'),
(2008400, 9, 24, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Visibility Off'),
(2008400, 9, 25, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 14, 24926, 184071, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set GO State Ready (Haramad\'s Holographic Stand)'),
(2008400, 9, 26, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 12, 19675, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 0, 4131.74, 2930.24, 354.607, 2.9942, 'Image of Nexus-Prince Haramad - Actionlist - Summon Creature \'Nexus-Prince Haramad\''),
(2008400, 9, 27, 0, 0, 0, 100, 0, 300000, 300000, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Visibility On'),
(2008400, 9, 28, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Npc Flags Gossip & Questgiver'),
(2008400, 9, 29, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 14, 24926, 184071, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set GO State Active (Haramad\'s Holographic Stand)'),
(2008400, 9, 30, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Active Off'),
(2008401, 9, 0, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Visibility On'),
(2008401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Npc Flags Gossip & Questgiver'),
(2008401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Image of Nexus-Prince Haramad - Actionlist - Set Active Off');

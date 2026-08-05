--
DELETE FROM `script_waypoint` WHERE `entry` = 25589;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 25589);
UPDATE `creature` SET `position_x` = 4414.2227, `position_y` = 5367.2993, `position_z` = -15.494027, `orientation` = 0.366519153118133544, `VerifiedBuild` = 68887, `CreateObject` = 1 WHERE `id` = 25589 AND `guid` = 2017;
UPDATE `creature_template_addon` SET `bytes1` = 0 WHERE (`entry` = 25589);

DELETE FROM `waypoint_data` WHERE `id` = 20170;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(20170, 1, 4417.7495, 5367.4985, -16.15369, NULL, 0),
(20170, 2, 4428.611, 5368.9023, -16.237024, NULL, 0),
(20170, 3, 4441.7505, 5370.4707, -16.181473, NULL, 0),
(20170, 4, 4456.576, 5371.09, -15.884483, NULL, 0),
(20170, 5, 4447.071, 5370.768, -16.09028, NULL, 0),
(20170, 6, 4456.576, 5371.09, -15.884483, NULL, 1000), -- Text: I think it's up this way to the left.  Let's go! (5)
(20170, 7, 4480.4556, 5376.1406, -14.972447, NULL, 0),
(20170, 8, 4482.503, 5394.4717, -15.247263, NULL, 0),
(20170, 9, 4472.4746, 5415.1953, -15.282103, NULL, 0),
(20170, 10, 4454.2, 5430.8335, -15.91428, NULL, 0),
(20170, 11, 4429.642, 5436.43, -15.247575, NULL, 0),
(20170, 12, 4400.7227, 5420.6387, -14.243102, NULL, 0),
(20170, 13, 4390.271, 5394.994, -7.2438426, NULL, 0),
(20170, 14, 4391.466, 5371.905, 0.35767198, NULL, 0),
(20170, 15, 4401.401, 5343.3447, 5.0264144, NULL, 0),
(20170, 16, 4423.773, 5333.25, 9.713379, NULL, 0),
(20170, 17, 4450.279, 5341.0005, 15.114364, NULL, 0),
(20170, 18, 4473.5034, 5356.4673, 18.74915, NULL, 0),
(20170, 19, 4483.5527, 5390.202, 25.259706, NULL, 0),
(20170, 20, 4477.1597, 5411.815, 29.634027, NULL, 0),
(20170, 21, 4454.4814, 5427.8823, 35.925766, NULL, 0),
(20170, 22, 4418.1353, 5435.3223, 40.207844, NULL, 0),
(20170, 23, 4394.032, 5445.513, 45.68608, NULL, 0),
(20170, 24, 4366.487, 5466.6772, 48.839, NULL, 0);

DELETE FROM `creature_text` WHERE (`CreatureID` = 25589);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25589, 0, 0, 'I AM NOT AN APPETIZER!', 12, 7, 100, 0, 0, 0, 24780, 0, 'Bonker Togglevolt - Aggro'),
(25589, 1, 0, 'Right then, no time to waste. Let\'s get outa here!', 12, 7, 100, 1, 0, 0, 24772, 0, 'Bonker Togglevolt - Quest Taken'),
(25589, 0, 1, 'Filthy creature!', 12, 7, 100, 0, 0, 0, 24777, 0, 'Bonker Togglevolt - Aggro'),
(25589, 0, 2, 'I came here to talk, but you mindless things tried to kill me instead!', 12, 7, 100, 0, 0, 0, 24778, 0, 'Bonker Togglevolt - Aggro'),
(25589, 0, 3, 'You won\'t put me in chains again!', 12, 7, 100, 0, 0, 0, 24779, 0, 'Bonker Togglevolt - Aggro'),
(25589, 2, 0, 'Here we go.', 12, 7, 100, 1, 0, 0, 24773, 0, 'Bonker Togglevolt - Start Escort'),
(25589, 3, 0, 'I think it\'s up this way to the left.  Let\'s go!', 12, 7, 100, 5, 0, 0, 24776, 0, 'Bonker Togglevolt - Escort Underway'),
(25589, 4, 0, 'Ah, fresh air! I can get myself back to the airstrip from here. Be sure to tell Fizzcrank I\'m back and safe. Thanks so much, $n!', 12, 7, 100, 1, 0, 0, 24774, 0, 'Bonker Togglevolt - Quest Completed'),
(25589, 4, 1, 'The airstrip at last! Thank you, I can make my way from here. Be sure to tell Fizzcrank I\'m back and safe!', 12, 7, 100, 1, 0, 0, 24775, 0, 'Bonker Togglevolt - Quest Completed');

UPDATE `creature_template` SET `unit_flags` = 32768, `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 25589);
/*
13:34:48.585 Quest Accepted
[25] NpcFlags: 0
[25] FactionTemplate: 10
[25] Flags: 32768
[25] StandState: 0

13:34:49.920
Text: Right then, no time to waste. Let's get outa here! (1)

13:35:00.868
Text: Here we go. (1)
Start Movement

13:37:15.767 -- Reached End
Completion Text (1)

13:37:26.804
Despawn
*/

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25589);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25589, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2558900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - On Respawn - Run Script'),
(25589, 0, 1, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - On Reached Home - Remove Npc Flags Gossip & Questgiver'),
(25589, 0, 2, 0, 4, 0, 50, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - On Aggro - Say Line'),
(25589, 0, 3, 0, 19, 0, 100, 0, 11673, 0, 0, 0, 0, 0, 80, 2558901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - On Quest \'Get Me Outa Here!\' Taken - Run Script'),
(25589, 0, 4, 0, 108, 0, 100, 0, 6, 20170, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - On Point 6 of Path 20170 Reached - Say Line 3'),
(25589, 0, 5, 0, 109, 0, 100, 0, 0, 20170, 0, 0, 0, 0, 80, 2558902, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - On Path 20170 Finished - Run Script'),
(25589, 0, 6, 7, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 10000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - On Just Died - Despawn In 10000 ms'),
(25589, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 11673, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - On Just Died - Fail Quest \'Get Me Outa Here!\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2558900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2558900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2558900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1973, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Set Faction 1973'),
(2558900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Set Flag Standstate Sit Down'),
(2558900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Add Npc Flags Gossip & Questgiver');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2558901);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2558901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Store Targetlist'),
(2558901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Remove Npc Flags Gossip & Questgiver'),
(2558901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Set Faction 10'),
(2558901, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2558901, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Remove FlagStandstate Sit Down'),
(2558901, 9, 5, 0, 0, 0, 100, 0, 1300, 1300, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Say Line 1'),
(2558901, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Say Line 2'),
(2558901, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 20170, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Start Path 20170');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2558902);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2558902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Say Line 4'),
(2558902, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 26, 11673, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Quest Credit \'Get Me Outa Here!\''),
(2558902, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 10000, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonker Togglevolt - Actionlist - Despawn In 10000 ms');

-- Finally, the ball aand chain
DELETE FROM `gameobject` WHERE `guid` = 2017 AND `id` = 175544;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(2017, 175544, 571, 3537, 4123, 1, 1, 4414.00244140625, 5368.28125, -15.5867462158203125, 3.595378875732421875, 0, 0, -0.97437000274658203, 0.224951311945915222, 120, 255, 1, 68887);

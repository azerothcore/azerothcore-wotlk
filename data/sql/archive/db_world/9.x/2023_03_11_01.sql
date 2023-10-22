-- DB update 2023_03_11_00 -> 2023_03_11_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `flags_extra` = 0, `unit_flags` = 32768, `ScriptName` = '' WHERE (`entry` = 17893);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17893);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17893, 0, 0, 0, 10, 0, 100, 257, 1, 15, 15000, 90000, 1, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Within 1-15 Range Out of Combat LoS - Say Line 0'),
(17893, 0, 1, 0, 4, 0, 100, 257, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - On Aggro - Say Line 2'),
(17893, 0, 2, 0, 62, 0, 100, 0, 7520, 0, 0, 0, 0, 80, 1789300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - On Gossip Option 0 Selected - Run Script'),
(17893, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33536, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - On Respawn - Set Flags Immune To Players & Immune To NPC\'s'),
(17893, 0, 4, 5, 62, 0, 100, 0, 7520, 1, 0, 0, 0, 11, 34906, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - On Gossip Option 1 Selected - Cast \'Mark of Bite\''),
(17893, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - On Gossip Option 1 Selected - Close Gossip'),
(17893, 0, 6, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 33, 17893, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - On Gossip Hello - Quest Credit \'null\''),
(17893, 0, 7, 0, 40, 0, 100, 0, 1, 1789300, 0, 0, 0, 80, 1789301, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - On Waypoint 1 Reached - Run Script'),
(17893, 0, 8, 0, 58, 0, 100, 0, 2, 1789300, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - On Waypoint 2 Reached - Add Npc Flags Gossip');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1789300, 1789301));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1789300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Store Targetlist'),
(1789300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Set Faction 113'),
(1789300, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(1789300, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Remove Npc Flags Gossip'),
(1789300, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 15, 182094, 10, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Activate Gameobject'),
(1789300, 9, 5, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 107, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Summon Creature Group 0'),
(1789300, 9, 6, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 53, 0, 1789300, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Start Waypoint'),
(1789301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 3440, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Pause Waypoint'),
(1789301, 9, 1, 0, 0, 0, 100, 0, 240, 240, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Set Orientation Stored Player'),
(1789301, 9, 2, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Naturalist Bite - Actionlist - Say Line 1');

DELETE FROM `waypoints` WHERE `entry`=1789300 AND `point_comment`='Naturalist Bite';
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(1789300, 1, -190.92549, -796.38947, 43.799316, NULL, 0, 'Naturalist Bite'),
(1789300, 2, -183.40784, -780.19904, 43.799313, NULL, 0, 'Naturalist Bite');

DELETE FROM `creature_text` WHERE `CreatureID`=17893 AND `GroupID`=2 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17893, 2, 0, 'I... HAVE HAD ENOUGH... OF... YOU!', 12, 0, 100, 0, 0, 0, 14584, 0, 'Naturalist Bite');

DELETE FROM `creature_summon_groups` WHERE `summonerId`=17893 AND `summonerType`=0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `comment`) VALUES
(17893, 0, 0, 17957, -101.13928, -745.353, 35.483814, 3.476041078567504882, 4, 30000, 'Naturalist Bite Event'),
(17893, 0, 0, 17960, -98.6582, -742.3795, 35.319103, 3.332194089889526367, 4, 30000, 'Naturalist Bite Event'),
(17893, 0, 0, 17961, -97.35107, -745.45483, 35.69915, 3.675448894500732421, 4, 30000, 'Naturalist Bite Event');

DELETE FROM `gossip_menu` WHERE (`MenuID` = 7520);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7520, 9119),
(7520, 9144);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 7520);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7520, 0, 0, 'Alright, Bite, I\'ll let you out.', 14574, 1, 1, 0, 0, 0, 0, '', 0, 0),
(7520, 1, 0, 'Naturalist, please grant me your boon.', 14670, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` IN (14, 15)) AND (`SourceGroup` = 7520) AND (`ConditionValue1` = 182094);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7520, 9119, 0, 0, 30, 1, 182094, 5, 0, 0, 0, 0, '', 'Only show if Naturalist Bite is imprisoned'),
(15, 7520, 0, 0, 0, 30, 1, 182094, 5, 0, 0, 0, 0, '', 'Only show if Naturalist Bite is imprisoned'),
(14, 7520, 9144, 0, 0, 30, 1, 182094, 5, 0, 1, 0, 0, '', 'Only show if Naturalist Bite is freed'),
(15, 7520, 1, 0, 0, 30, 1, 182094, 5, 0, 1, 0, 0, '', 'Only show if Naturalist Bite is freed');

DELETE FROM `creature_text` WHERE `CreatureID`=17957 AND `comment` LIKE 'Coilfang Champion%';
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17957, 1, 0, 'Intrudersss with the prisssoner!  Kill them!!!', 14, 0, 100, 0, 0, 0, 15896, 0, 'Coilfang Champion - Naturalist Bite Event'),
(17957, 0, 0, 'Die, warmblood!', 12, 0, 100, 0, 0, 0, 16710, 0, 'Coilfang Champion'),
(17957, 0, 1, 'For the Master!', 12, 0, 100, 0, 0, 0, 16708, 0, 'Coilfang Champion'),
(17957, 0, 2, 'Illidan reigns!', 12, 0, 100, 0, 0, 0, 16709, 0, 'Coilfang Champion'),
(17957, 0, 3, 'My blood is like venom!', 12, 0, 100, 0, 0, 0, 16712, 0, 'Coilfang Champion');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17957) AND (`source_type` = 0) AND (`id` = 4);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17957, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Champion - On Just Summoned - Say Line 1');

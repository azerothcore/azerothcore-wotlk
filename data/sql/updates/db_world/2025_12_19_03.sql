-- DB update 2025_12_19_02 -> 2025_12_19_03
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24788);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24788, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - On Reset - Set Emote State 10'),
(24788, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - On Data Set 1 1 - Say Line 0'),
(24788, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - On Data Set 1 1 - Set Faction 35'),
(24788, 0, 3, 4, 62, 0, 100, 512, 9013, 0, 0, 0, 0, 0, 56, 34116, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - On Gossip Option 0 Selected - Add Item \'Jack Adams\' Debt\' 1 Time'),
(24788, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - On Gossip Option 0 Selected - Close Gossip'),
(24788, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - On Gossip Option 0 Selected - Remove Npc Flags Gossip'),
(24788, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - On Respawn - Remove Npc Flags Gossip'),
(24788, 0, 7, 0, 38, 0, 100, 512, 2, 2, 0, 0, 0, 0, 80, 2478800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - On Data Set 2 2 - Run Script'),
(24788, 0, 8, 0, 1, 1, 100, 0, 30000, 30000, 30000, 30000, 0, 0, 80, 2478801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - Out of Combat - Run Script');

DELETE FROM `gossip_menu` WHERE (`MenuID` = 9014);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9014, 12180);

DELETE FROM `creature_text` WHERE (`CreatureID` = 24788) AND (`GroupID` IN (3, 4));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24788, 3, 0, '<Discreetly search the pirate\'s pockets for Taruk\'s payment.>', 16, 0, 100, 0, 0, 0, 23824, 0, 'Jack Adams'),
(24788, 4, 0, 'What are you lot looking at?  Pour me another drink!', 12, 0, 100, 5, 0, 0, 23825, 0, 'Jack Adams');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2478801);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2478801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - Actionlist - Set Event Phase 0'),
(2478801, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - Actionlist - Remove Aura \'Permanent Feign Death\''),
(2478801, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - Actionlist - Remove Npc Flags Gossip'),
(2478801, 9, 3, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - Actionlist - Say Line 3'),
(2478801, 9, 4, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - Actionlist - Say Line 4'),
(2478801, 9, 5, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 17, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - Actionlist - Set Emote State 10'),
(2478801, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 19, 24639, 30, 0, 0, 0, 0, 0, 0, 'Jack Adams - Actionlist - Set Npc Flags Gossip');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2478800) AND (`source_type` = 9) AND (`id` IN (8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2478800, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - Actionlist - Set Event Phase 1');

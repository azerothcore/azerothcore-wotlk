-- DB update 2023_03_22_02 -> 2023_03_22_03
-- Brazen (18725)
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 18725;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18725, 0, 0, 1, 62, 0, 100, 0, 7959, 0, 0, 0, 0, 11, 32892, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Brazen - On Gossip Option 0 Selected - Cast \'Brazen Taxi\''),
(18725, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Brazen - On Linked Actions - Close Gossip'),
(18725, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Brazen - On Data Set - Talk (Invoker)');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=7959;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7959, 9779, 0, 0, 2, 0, 25853, 1, 0, 0, 0, 0, '', 'Brazen - Show gossip menu text if player has item 25853'),
(14, 7959, 9780, 0, 0, 2, 0, 25853, 1, 0, 1, 0, 0, '', 'Brazen - Show gossip menu text if player does not have item 25853'),
(15, 7959, 0, 0, 0, 2, 0, 25853, 1, 0, 0, 0, 0, '', 'Brazen - Show gossip option 0 if player has item 25853');

-- Erozion (18723)
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 18723;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18723, 0, 0, 1, 62, 0, 100, 512, 7769, 0, 0, 0, 0, 56, 25853, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Erozion - On Gossip Option 0 Selected - Add Item \'Pack of Incendiary Bombs\''),
(18723, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Erozion - On Gossip Option 0 Selected - Close Gossip'),
(18723, 0, 2, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Erozion - On Gossip Option 0 Selected - Store Targetlist'),
(18723, 0, 3, 4, 19, 0, 100, 512, 10283, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Erozion - On Quest \'Taretha\'s Diversion\' Taken - Store Targetlist'),
(18723, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 18725, 20, 0, 0, 0, 0, 0, 0, 'Erozion - On Gossip Option 0 Selected - Send Target 1'),
(18723, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 18725, 20, 0, 0, 0, 0, 0, 0, 'Erozion - On Gossip Option 0 Selected - Set Data 1 1');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup`=7769;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7769, 0, 0, 0, 2, 0, 25853, 1, 0, 1, 0, 0, '', '(AND) Erozion - Show gossip menu option if player doesn\'t have item 25853'),
(15, 7769, 0, 0, 0, 47, 0, 10283, 74, 0, 0, 0, 0, '', '(AND) Erozion - Show gossip menu option if quest 10283 has been rewarded or incomplete.');

-- DB update 2023_03_20_05 -> 2023_03_20_06
-- Delete wrong creature_text for Ashyen(17900) and Keleth(17901) and set as SAI.
DELETE FROM `creature_text` WHERE `CreatureID` IN (17900,17901);
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` IN (17900,17901);

-- Ashyen
DELETE FROM `gossip_menu_option` WHERE `MenuID`=7559;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7559, 0, 0, 'Grant me your mark, wise ancient.', 14739, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 17900 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17900, 0, 0, 5, 62, 0, 100, 0, 7559, 0, 0, 0, 0, 11, 31808, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Cast \'Mark of Lore\' (Friendly)'),
(17900, 0, 1, 5, 62, 0, 100, 0, 7559, 0, 0, 0, 0, 11, 31810, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Cast \'Mark of Lore\' (Honored)'),
(17900, 0, 2, 5, 62, 0, 100, 0, 7559, 0, 0, 0, 0, 11, 31811, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Cast \'Mark of Lore\' (Revered)'),
(17900, 0, 3, 5, 62, 0, 100, 0, 7559, 0, 0, 0, 0, 11, 31815, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Cast \'Mark of Lore\' (Exalted)'),
(17900, 0, 4, 5, 62, 0, 100, 0, 7559, 0, 0, 0, 0, 33, 17900, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Gossip Option 0 Selected - Quest Credit \'Blessings of the Ancients\''),
(17900, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ashyen - On Link - Close Gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=17900;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 17900, 0, 0, 5, 0, 942, 16, 0, 0, 0, 0, '', 'Execute SAI (Action 0) if player is Friendly with Cenarion Expedition'),
(22, 2, 17900, 0, 0, 5, 0, 942, 32, 0, 0, 0, 0, '', 'Execute SAI (Action 1) if player is Honored with Cenarion Expedition'),
(22, 3, 17900, 0, 0, 5, 0, 942, 64, 0, 0, 0, 0, '', 'Execute SAI (Action 2) if player is Revered with Cenarion Expedition'),
(22, 4, 17900, 0, 0, 5, 0, 942, 128, 0, 0, 0, 0, '', 'Execute SAI (Action 3) if player is Exalted with Cenarion Expedition');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=7559;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7559, 0, 0, 0, 5, 0, 942, 240, 0, 0, 0, 0, '', 'Show Gossip Option 0 if player is at least Friendly with Cenarion Expedition');

-- Keleth 
DELETE FROM `gossip_menu_option` WHERE `MenuID`=7560;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7560, 0, 0, 'Grant me your mark, mighty ancient.', 14741, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 17901 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17901, 0, 0, 5, 62, 0, 100, 0, 7560, 0, 0, 0, 0, 11, 31807, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Cast \'Mark of War\' (Friendly'),
(17901, 0, 1, 5, 62, 0, 100, 0, 7560, 0, 0, 0, 0, 11, 31812, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Cast \'Mark of War\' (Honored)'),
(17901, 0, 2, 5, 62, 0, 100, 0, 7560, 0, 0, 0, 0, 11, 31813, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Cast \'Mark of War\' (Revered)'),
(17901, 0, 3, 5, 62, 0, 100, 0, 7560, 0, 0, 0, 0, 11, 31814, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Cast \'Mark of War\' (Exalted)'),
(17901, 0, 4, 5, 62, 0, 100, 0, 7560, 0, 0, 0, 0, 33, 17901, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Gossip Option 0 Selected - Quest Credit \'Blessings of the Ancients\''),
(17901, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Keleth - On Link - Close Gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=17901;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 17901, 0, 0, 5, 0, 942, 16, 0, 0, 0, 0, '', 'Execute SAI (Action 0) if player is Friendly with Cenarion Expedition'),
(22, 2, 17901, 0, 0, 5, 0, 942, 32, 0, 0, 0, 0, '', 'Execute SAI (Action 1) if player is Honored with Cenarion Expedition'),
(22, 3, 17901, 0, 0, 5, 0, 942, 64, 0, 0, 0, 0, '', 'Execute SAI (Action 2) if player is Revered with Cenarion Expedition'),
(22, 4, 17901, 0, 0, 5, 0, 942, 128, 0, 0, 0, 0, '', 'Execute SAI (Action 3) if player is Exalted with Cenarion Expedition');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=7560;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7560, 0, 0, 0, 5, 0, 942, 240, 0, 0, 0, 0, '', 'Show Gossip Option 0 if player is at least Friendly with Cenarion Expedition');

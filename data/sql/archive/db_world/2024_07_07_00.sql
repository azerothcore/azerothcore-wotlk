-- DB update 2024_07_06_11 -> 2024_07_07_00
--
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 161);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(161, 0, 0, 'Mennet said I should ask you for a set of thieves\' tools.', 2621, 1, 1, 0, 0, 0, 0, NULL, 0, 0),
(161, 1, 0, 'I need another set of thieves\' tools.', 2643, 1, 1, 0, 0, 0, 0, '', 0, 0);


UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6566;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 6566);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6566, 0, 0, 2, 62, 0, 100, 0, 161, 0, 0, 0, 0, 0, 11, 9949, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Estelle Gendry - On Gossip Option 0 Selected - Cast \'Thieves` Tool Rack Conjure\''),
(6566, 0, 1, 2, 62, 0, 100, 0, 161, 1, 0, 0, 0, 0, 11, 9949, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Estelle Gendry - On Gossip Option 1 Selected - Cast \'Thieves` Tool Rack Conjure\''),
(6566, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Estelle Gendry - On Gossip Option Selected - Close Gossip');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 161);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 161, 0, 0, 0, 2, 0, 5060, 1, 1, 1, 0, 0, '', 'Estelle Gendry should not give player Thieves\' Tools if the player has one already'),
(15, 161, 0, 0, 0, 2, 0, 5060, 1, 0, 1, 0, 0, '', 'Estelle Gendry should not give player Thieves\' Tools if the player has one already'),
(15, 161, 0, 0, 0, 47, 0, 1999, 10, 0, 0, 0, 0, '', 'Estelle Gendry should only give player Thieves\' Tools if the player is on the appropriate quest'),

(15, 161, 1, 0, 0, 2, 0, 5060, 1, 1, 1, 0, 0, '', 'Estelle Gendry should not give player Thieves\' Tools if the player has one already'),
(15, 161, 1, 0, 0, 2, 0, 5060, 1, 0, 1, 0, 0, '', 'Estelle Gendry should not give player Thieves\' Tools if the player has one already'),
(15, 161, 1, 0, 0, 47, 0, 1999, 64, 0, 0, 0, 0, '', 'Estelle Gendry should only give player Thieves\' Tools if the player has completed the appropriate quest');

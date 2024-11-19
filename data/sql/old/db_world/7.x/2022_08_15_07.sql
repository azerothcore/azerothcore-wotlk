-- DB update 2022_08_15_06 -> 2022_08_15_07
DELETE FROM `creature_queststarter` WHERE `quest` IN (6821, 6822, 6823, 6824, 7486) AND `id` = 13278;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(13278, 6821), -- Eye of the Emberseer
(13278, 6822), -- The Molten Core
(13278, 6823), -- Agent of Hydraxis
(13278, 6824), -- Hands of the Enemy
(13278, 7486); -- A Hero's Reward

DELETE FROM `creature_questender` WHERE `quest` IN (6804, 6821, 6822, 6823, 6824) AND `id` = 13278;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(13278, 6804), -- Poisoned Water
(13278, 6821), -- Eye of the Emberseer
(13278, 6822), -- The Molten Core
(13278, 6823), -- Agent of Hydraxis
(13278, 6824); -- Hands of the Enemy

DELETE FROM `quest_template_addon` WHERE `ID` IN (6821, 6822, 6823, 6824, 7486);
INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`, `NextQuestID`) VALUES
(6821, 6805, 6822),
(6822, 6021, 6823),
(6823, 6022, 6824),
(6824, 6823, 7486),
(7486, 6824, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` = 6821;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 6821, 0, 0, 47, 0, 6804, 64, 0, 0, 0, 0, '', 'Quest Eyes of the Emberseer available if quest Poisoned Water has been rewarded.'),
(19, 0, 6821, 0, 0, 47, 0, 6805, 64, 0, 0, 0, 0, '', 'Quest Eyes of the Emberseer available if quest Stormers and Rumblers has been rewarded.');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 5065) AND (`SourceId` IN (0, 1));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 5065, 0, 0, 0, 5, 0, 749, 224, 0, 0, 0, 0, '', 'Duke Hydraxis - Create Aqual Quintessence Gossip - Requires Honored Rep'),
(15, 5065, 0, 0, 0, 47, 0, 6824, 64, 0, 0, 0, 0, '', 'Duke Hydraxis - Aqual Quintessence Gossip available if quest Hand of the Enemy rewarded.'),
(15, 5065, 1, 0, 0, 5, 0, 749, 192, 0, 0, 0, 0, '', 'Duke Hydraxis - Create Eternal Quintessence Gossip - Requires Revered Rep'),
(15, 5065, 1, 0, 0, 47, 0, 6824, 64, 0, 0, 0, 0, '', 'Duke Hydraxis - Create Eternal Quintessence Gossip - Requires Hand of the Enemy rewarded');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` IN (6822, 6823, 6824, 7486);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 6822, 0, 0, 47, 0, 6821, 64, 0, 0, 0, 0, '', 'Quest Molten Core available if quest Eye of the Emberseer has been rewarded.'),
(19, 0, 6823, 0, 0, 47, 0, 6822, 64, 0, 0, 0, 0, '', 'Quest Agent of Hydraxis available if quest Molten Core has been rewarded.'),
(19, 0, 6824, 0, 0, 47, 0, 6823, 64, 0, 0, 0, 0, '', 'Quest Hands of the Enemy available if quest Agents of Hydraxis has been rewarded.'),
(19, 0, 7486, 0, 0, 47, 0, 6824, 64, 0, 0, 0, 0, '', 'Quest A Hero\'s Reward available if quest Hands of the Enemy has been rewarded.');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` IN (6822, 6823, 6824, 7486);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 6822, 0, 0, 47, 0, 6821, 64, 0, 0, 0, 0, '', 'Quest Molten Core available if quest Eye of the Emberseer has been rewarded.'),
(19, 0, 6823, 0, 0, 47, 0, 6822, 64, 0, 0, 0, 0, '', 'Quest Agent of Hydraxis available if quest Molten Core has been rewarded.'),
(19, 0, 6824, 0, 0, 47, 0, 6823, 64, 0, 0, 0, 0, '', 'Quest Hands of the Enemy available if quest Agents of Hydraxis has been rewarded.'),
(19, 0, 7486, 0, 0, 47, 0, 6824, 64, 0, 0, 0, 0, '', 'Quest A Hero\'s Reward available if quest Hands of the Enemy has been rewarded.');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 13278;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 13278) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(13278, 0, 0, 1, 62, 0, 100, 0, 5065, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Hydraxis - On Gossip Option 0 Selected - Close Gossip'),
(13278, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 56, 17333, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Hydraxis - On Link - Add item \'Aqual Quintessence\''),
(13278, 0, 2, 3, 62, 0, 100, 0, 5065, 1, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Hydraxis - On Gossip Option 1 Selected - Close Gossip'),
(13278, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 56, 22754, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Duke Hydraxis - On Link - Add item \' Eternal Quintessence\'');

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 5065 AND `OptionID` IN (0, 1);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(5065,0,0,'I require a vial of aqual quintessence, Hydraxis, for I go to the Molten Core to extinguish a rune of the Firelords.',8666,1,2,0,0,0,0,'',0,0),
(5065,1,0,'I desire this eternal quintessence, Duke Hydraxis.',12363,1,2,0,0,0,0,'',0,0);

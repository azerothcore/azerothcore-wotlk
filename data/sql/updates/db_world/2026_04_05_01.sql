-- DB update 2026_04_05_00 -> 2026_04_05_01
--
-- Alexstrasza the Life-Binder (Dragonblight) - Add Focusing Iris key menu_option. (Previously empty)
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 10192;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(10192, 0, 0, 'Oh great Queen of the Dragons, I have somehow misplaced my Key to the Focusing Iris. Can you find it for me?', 32832, 1, 1, 0, 0, 0, 0, '', 0, 0),
(10192, 1, 0, 'Oh great Queen of the Dragons, I have somehow misplaced my Heroic Key to the Focusing Iris. Can you find it for me?', 32836, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 10192) AND (`SourceEntry` IN (0, 1)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 10192, 0, 0, 0, 8, 0, 13372, 0, 0, 0, 0, 0, '', 'must have completed Quest \'The Key to the Focusing Iris\''),
(15, 10192, 0, 0, 0, 2, 0, 44582, 1, 1, 1, 0, 0, '', 'must not have item \'Key to the Focusing Iris\''),
(15, 10192, 1, 0, 0, 8, 0, 13375, 0, 0, 0, 0, 0, '', 'must have completed Quest \'The Heroic Key to the Focusing Iris\''),
(15, 10192, 1, 0, 0, 2, 0, 44581, 1, 1, 1, 0, 0, '', 'must not have item \'Heroic Key to the Focusing Iris\'');

UPDATE `spell_dbc` SET `Targets` = 1, `Effect_1` = 24, `EffectBasePoints_1` = 1, `EffectItemType_1` = 44582 WHERE (`ID` = 60989);
UPDATE `spell_dbc` SET `Targets` = 1, `Effect_1` = 24, `EffectBasePoints_1` = 1, `EffectItemType_1` = 44581 WHERE (`ID` = 60992);

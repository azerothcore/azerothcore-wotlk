-- DB update 2026_03_07_04 -> 2026_03_08_00
--
-- Remove misplaced "Yes, please!" option from menu 9586.
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 9586 AND `OptionID` = 1;
DELETE FROM `gossip_menu_option_locale` WHERE `MenuID` = 9586 AND `OptionID` = 1;

-- Show "Welcome, adventurer. You've come just in the nick..." if intro has not been completed yet
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 9586) AND (`SourceEntry` IN (12939, 13470, 13471));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 9586, 13470, 0, 0, 13, 0, 7, 1, 0, 0, 0, 0, '', 'intro event must be completed'),
(14, 9586, 13471, 0, 0, 2, 0, 37888, 1, 0, 0, 0, 0, '', 'must have item Arcane Disruptor'),
(14, 9586, 13471, 0, 0, 13, 0, 7, 0, 0, 0, 0, 0, '', 'intro event must not be completed');

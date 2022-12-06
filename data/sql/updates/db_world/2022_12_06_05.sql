-- DB update 2022_12_06_04 -> 2022_12_06_05
--
DELETE FROM `gossip_menu` WHERE `MenuID`=9581 AND `TextID`=12932;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9581, 12932);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup`=9581;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 9581, 12932, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 9581, 12933, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage');

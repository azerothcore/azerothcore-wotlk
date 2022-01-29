INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642779550112004300');

DELETE FROM `gossip_menu` WHERE `MenuID` in (4821, 4824, 4825, 4827) AND `TextID` in (5874, 5880, 5882, 5886);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(4821, 5874),
(4824, 5880),
(4825, 5882),
(4827, 5886);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 and `SourceGroup` in (4821, 4822, 4824, 4825, 4827) and `ConditionTypeOrReference` = 15 and `SourceEntry` in (5873, 5874, 5875, 5876, 5879, 5880, 5881, 5882, 5885, 5886);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 4821, 5873, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4821, 5874, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage'),
(14, 4822, 5875, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4822, 5876, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage'),
(14, 4824, 5879, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4824, 5880, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage'),
(14, 4825, 5881, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage'),
(14, 4825, 5882, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4827, 5885, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4827, 5886, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622465489637988400');

DELETE FROM `gossip_menu` WHERE `MenuID` = 7183 AND `TextID` = 8462;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (7183, 8462);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 7183) AND (`SourceEntry` IN (8462,8619)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 16) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 512) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7183, 8619, 0, 0, 16, 0, 512, 0, 0, 0, 0, 0, '', 'Advisor Sorrelon - Show Blood Elf gossip text'),
(14, 7183, 8462, 0, 0, 16, 0, 512, 0, 0, 1, 0, 0, '', 'Advisor Sorrelon - Show generic Horde gossip text');

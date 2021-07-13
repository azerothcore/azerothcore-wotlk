INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626186297807070700');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 7403) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 16) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 1024) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7403, 0, 0, 0, 16, 0, 1024, 0, 0, 0, 0, 0, '', 'Enable GOSSIP_MENU_OPTION only for Draenei');


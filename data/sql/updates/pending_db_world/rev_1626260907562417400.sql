INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626260907562417400');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 7983) AND (`SourceEntry` = 9039) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 9663) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 7434) AND (`SourceEntry` = 9039) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 9663) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7434, 9039, 0, 0, 9, 0, 9663, 0, 0, 0, 0, 0, '', 'Show gossip text 9039 if player has quest 9663');

UPDATE `gossip_menu` SET `MenuID` = 7434 WHERE `MenuID` = 7983 AND `TextID` = 9039;

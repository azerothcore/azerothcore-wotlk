INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647992044021568600');

DELETE FROM `conditions` WHERE `SourceGroup` = 643;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(14, 643, 1203, 0, 0, 7, 0, 182, 1, 0, 0, 0, 0, '', 'Show gossip text if player is a Herbalist'),
(14, 643, 1202, 0, 0, 7, 0, 182, 0, 0, 0, 0, 0, '', 'Show gossip text if player is not a Herbalist');

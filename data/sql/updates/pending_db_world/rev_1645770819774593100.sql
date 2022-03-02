INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645770819774593100');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` IN (7461, 7463, 8716, 8717, 12396) AND `SourceEntry` IN (21104, 21105);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 8716, 21104, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter II will drop only when a player have The Only Prescription (8620) in their quest log'),
(1, 8717, 21104, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter II will drop only when a player have The Only Prescription (8620) in their quest log'),
(1, 12396, 21104, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter II will drop only when a player have The Only Prescription (8620) in their quest log'),
(1, 7463, 21105, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter III will drop only when a player have The Only Prescription (8620) in their quest log'),
(1, 7461, 21105, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter III will drop only when a player have The Only Prescription (8620) in their quest log');

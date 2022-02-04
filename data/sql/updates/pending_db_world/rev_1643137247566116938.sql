INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643137247566116938');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=11361 AND `ConditionValue1` IN (7003, 7721);

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15, 11361, 0, 0, 1, 8, 0, 7003, 0, 0, 0, 0, 0, '', 'Show gossip option if Quests Zapped Giants and  Fuel for the Zapping are rewarded'),
(15, 11361, 0, 0, 1, 8, 0, 7721, 0, 0, 0, 0, 0, '', 'Show gossip option if Quests Zapped Giants and  Fuel for the Zapping are rewarded');

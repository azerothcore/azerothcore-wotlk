INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635282917364687995');

-- Condition for source Quest available condition type Quest taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=1790 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 1790, 0, 0, 2, 0, 6866, 1, 1, 1, 0, 0, '', 'Quest The Symbol of Life available if player does not hava 1 of Symbol of Life.'),
(19, 0, 1790, 0, 0, 47, 0, 1781, 64, 0, 0, 0, 0, '', 'Quest The Symbol of Life available if quest The Tome of Divinity has been rewarded.'),
(19, 0, 1790, 0, 0, 47, 0, 1786, 64, 0, 1, 0, 0, '', 'Quest The Symbol of Life available if quest The Tome of Divinity has not been rewarded.');
-- Remove previous quest from quest_template_addon for quest
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=1790;

-- Condition for source Quest available condition type Quest taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=1789 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 1789, 0, 0, 2, 0, 6866, 1, 1, 1, 0, 0, '', 'Quest The Symbol of Life available if player does not hava 1 of Symbol of Life.'),
(19, 0, 1789, 0, 0, 47, 0, 1779, 64, 0, 0, 0, 0, '', 'Quest The Symbol of Life available if quest The Tome of Divinity has been rewarded.'),
(19, 0, 1789, 0, 0, 47, 0, 1783, 64, 0, 1, 0, 0, '', 'Quest The Symbol of Life available if quest The Tome of Divinity has not been rewarded.');
-- Remove previous quest from quest_template_addon for quest
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=1789;

-- Condition for source Quest available condition type Quest taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=1647 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 1647, 0, 0, 47, 0, 1646, 64, 0, 0, 0, 0, '', 'Quest The Symbol of Life available if quest The Tome of Divinity has been rewarded.');

UPDATE `creature_loot_template` SET `QuestRequired` = 0 WHERE `Item` = 12722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 10801 AND `SourceEntry` = 12722 AND `ConditionTypeOrReference` = 9;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(1, 10801, 12722, 0, 0, 9, 0, 5051, 0, 0, 0, 0, 0, '', 'Jabbering Ghoul - Good Luck Other-Half-Charm');

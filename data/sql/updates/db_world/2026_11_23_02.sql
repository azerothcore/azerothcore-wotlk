-- DB update 2026_11_23_01 -> 2026_11_23_02
--
-- Alchemy mastery quests need no introduction quest rewarded
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` IN (10897, 10899, 10902);

-- Alchemy introduction quests are not offered once any mastery quest is taken or rewarded
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceGroup` = 0 AND `SourceEntry` IN (10905, 10906, 10907) AND `SourceId` = 0 AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 101 AND `ConditionTarget` = 0 AND `ConditionValue1` IN (10897, 10899, 10902) AND `ConditionValue2` = 0 AND `ConditionValue3` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 10905, 0, 0, 101, 0, 10897, 0, 0, 0, 0, 0, '', 'Quest 10905 Master of Potions (introduction) available only if no other alchemy mastery quest is taken or rewarded'),
(19, 0, 10906, 0, 0, 101, 0, 10902, 0, 0, 0, 0, 0, '', 'Quest 10906 Master of Elixirs (introduction) available only if no other alchemy mastery quest is taken or rewarded'),
(19, 0, 10907, 0, 0, 101, 0, 10899, 0, 0, 0, 0, 0, '', 'Quest 10907 Master of Transmutation (introduction) available only if no other alchemy mastery quest is taken or rewarded');

--
-- Fix breadcrumb quest interaction for Find Sage Mistwalker (11287) and The Artifacts of Steel Gate (11286)
-- 11287 is an optional breadcrumb - player can skip it and go directly to 11286
-- If player takes 11286 first, breadcrumb 11287 should become unavailable
--
DELETE FROM `quest_template_addon` WHERE `ID` IN (11286, 11287);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(11286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11287, 0, 0, 0, 11261, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` = 11287;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 11287, 0, 0, 9, 0, 11286, 0, 0, 1, 0, 0, '', 'Find Sage Mistwalker - Not available if The Artifacts of Steel Gate is taken'),
(19, 0, 11287, 0, 0, 8, 0, 11286, 0, 0, 1, 0, 0, '', 'Find Sage Mistwalker - Not available if The Artifacts of Steel Gate is rewarded');

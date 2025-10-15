-- Fix quest 11929 "The Fall of Taunka'le Village" (first quest) - should point to 11930
UPDATE `quest_template_addon` SET `PrevQuestID` = 0, `NextQuestID` = 11930 WHERE (`ID` = 11929);
-- Fix quest 11930 "Across Transborea" - should point to 11977
UPDATE `quest_template_addon` SET `PrevQuestID` = 11929, `NextQuestID` = 11977 WHERE (`ID` = 11930);
-- Fix quest 11977 "A Tauren Among Taunka" / "The Taunka and the Tauren" - should point to 11978
UPDATE `quest_template_addon` SET `PrevQuestID` = 11930, `NextQuestID` = 11978 WHERE (`ID` = 11977);
-- Fix quest 11978 "Into the Fold" - should point to 11983 but shouldn't have prereq
-- see https://www.wowhead.com/wotlk/quest=11978/into-the-fold#comments:id=957398
UPDATE `quest_template_addon` SET `PrevQuestID` = 0, `NextQuestID` = 11983 WHERE (`ID` = 11978);
-- Fix quest 11983 "Blood Oath of the Horde" - should point to 12008
UPDATE `quest_template_addon` SET `PrevQuestID` = 11978, `NextQuestID` = 12008 WHERE (`ID` = 11983);
-- Fix quest 12008 "Agmar's Hammer" (last quest) - no next quest
UPDATE `quest_template_addon` SET `PrevQuestID` = 11983, `NextQuestID` = 0 WHERE (`ID` = 12008);

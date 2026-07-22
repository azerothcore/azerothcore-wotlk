-- DB update 2026_07_22_07 -> 2026_07_22_08
-- To Dragon's Fall - requires all three Wanted quests
UPDATE `quest_template_addon` SET `PrevQuestID` = 12089 WHERE `ID` = 12095;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = -12089 WHERE `ID` IN (12089, 12090, 12091);

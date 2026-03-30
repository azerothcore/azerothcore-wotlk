-- DB update 2024_11_06_01 -> 2024_11_06_02
-- Quest 'Strange Energy'
UPDATE `quest_template_addon` SET `NextQuestID` = 0, `ExclusiveGroup` = 0 WHERE `ID` IN (9957,9960,9961);
UPDATE `quest_template_addon` SET `ExclusiveGroup` = -9968 WHERE `ID` IN (9968,9971);
